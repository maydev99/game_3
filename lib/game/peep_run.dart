import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/actors/enemy_manager.dart';
import 'package:layout/actors/mr_peep.dart';
import 'package:layout/audio/audio_manager.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/level/level_data.dart';
import 'package:layout/overlays/game_over.dart';
import 'package:layout/overlays/level_up_overlay.dart';
import 'package:layout/overlays/pause_overlay.dart';

import '../overlays/hud.dart';

class PeepGame extends FlameGame with TapDetector, HasCollidables {
  late EnemyManager enemyManager;
  late GameDataProvider gameDataProvider;
  final box = GetStorage();
  late ParallaxComponent parallaxComponent;

  int savedLevel = 1;
  int savedScore = 0;
  int savedLives = 5;
  int level = 0;
  int newLevelLives = 5;
  int bonusPoints = 25;
  var levelData = LevelData();

  static const _audioAssets = [
    'funnysong.mp3',
    'new_jump.mp3',
    'level_up.mp3',
    'chicken_scream.mp3'
  ];

  late MrPeeps mrPeeps;

  @override
  Future<void>? onLoad() async {
    gameDataProvider = GameDataProvider();
    await images.load('tort.png');
    await images.load('peeps4.png');
    await images.load('bird.png');
    await images.load('dog.png');
    await images.load('rocket_tort.png');

    await AudioManager.instance.init(_audioAssets);

    loadLevelState();
    int myIndex = savedLevel - 1;

    parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData(levelData.data[myIndex].bg1),
        ParallaxImageData(levelData.data[myIndex].bg2),
        ParallaxImageData(levelData.data[myIndex].bg3),
        ParallaxImageData(levelData.data[myIndex].bg4),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.9, 0),
    );

    mrPeeps = MrPeeps(images.fromCache('peeps4.png'));
    enemyManager = EnemyManager();
    startGamePlay();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    int index = savedLevel - 1;
    overlays.add(Hud.id);

    //Game Over
    if (gameDataProvider.currentLives <= 0) {
      overlays.remove(Hud.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
      var score = gameDataProvider.currentPoints;
      var highScore = box.read('high');
      highScore ??= 0;
      if (score > highScore) {
        box.write('high', score);
      }
      overlays.add(GameOver.id);
    }

    //This handles the level changes
    if (gameDataProvider.currentPoints == levelData.data[index].endScore) {
      endLevel(nextLevel: index + 2);
      AudioManager.instance.playSfx('level_up.mp3', 1.0);
    }

    super.update(dt);
  }

  void endLevel({required int nextLevel}) {
    int index = nextLevel - 1;
    pauseEngine();
    AudioManager.instance.stopBgm();
    level = nextLevel;
    remove(mrPeeps);
    enemyManager.removeAllEnemies();
    remove(enemyManager);
    saveLevelState(level, gameDataProvider.currentLives + newLevelLives,
        gameDataProvider.currentPoints + bonusPoints);
    setParallax(index);
    overlays.add(LevelUpOverlay.id);
  }

  @override
  void onTapDown(TapDownInfo info) {
    mrPeeps.jump();
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!(overlays.isActive(PauseOverlay.id)) &&
            !(overlays.isActive(GameOver.id))) {
          resumeEngine();
        }

        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
        if (overlays.isActive(Hud.id)) {
          overlays.remove(Hud.id);
          overlays.add(PauseOverlay.id);
          AudioManager.instance.pauseBgm();
        }

        pauseEngine();

        break;
    }
    super.lifecycleStateChange(state);
  }

  void resetGame() {
    enemyManager.removeAllEnemies();
    enemyManager.removeFromParent();
    add(enemyManager);
  }

  void startGamePlay() {
    AudioManager.instance.stopBgm();
    loadLevelState();
    int index = savedLevel - 1;
    setParallax(index);
    add(parallaxComponent);
    AudioManager.instance.startBgm(levelData.data[index].bgm);
    add(mrPeeps);
    mrPeeps.changePriorityWithoutResorting(1);
  }

  Future<void> setParallax(int myIndex) async {
    parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData(levelData.data[myIndex].bg1),
        ParallaxImageData(levelData.data[myIndex].bg2),
        ParallaxImageData(levelData.data[myIndex].bg3),
        ParallaxImageData(levelData.data[myIndex].bg4),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.9, 0),
    );
  }

  void spawnEnemies() {
    // overlays.add(Hud.id);
    add(enemyManager);
    enemyManager.changePriorityWithoutResorting(2);
  }

  void saveLevelState(int level, int lives, int score) {
    box.write('level', level);
    box.write('lives', lives);
    box.write('score', score);
  }

  void loadLevelState() {
    savedLevel = box.read('level') ?? 1;
    savedLives = box.read('lives') ?? 5;
    savedScore = box.read('score') ?? 0;
    gameDataProvider.setPoints(savedScore);
    gameDataProvider.setLives(savedLives);
  }
}
