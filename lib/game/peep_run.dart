import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/actors/artifact_manager.dart';
import 'package:layout/actors/enemy_manager.dart';
import 'package:layout/actors/mr_peep.dart';
import 'package:layout/audio/audio_manager.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/level/level_data.dart';
import 'package:layout/overlays/game_over.dart';
import 'package:layout/overlays/game_won_overlay.dart';
import 'package:layout/overlays/level_up_overlay.dart';
import 'package:layout/overlays/pause_overlay.dart';

import '../overlays/hud.dart';



class PeepGame extends FlameGame with TapDetector, HasCollisionDetection {

  late EnemyManager enemyManager;
  late ArtifactManager artifactManager;
  late GameDataProvider gameDataProvider;
  final box = GetStorage();
  late ParallaxComponent parallaxComponent;

  int savedLevel = 1;
  int savedScore = 0;
  int savedLives = 5;
  int level = 0;
  int newLevelLives = 5;
  int bonusPoints = 25;
  int maxPoints = 500;
  var levelData = LevelData();



  static const _audioAssets = [
    'funnysong.mp3',
    'jazzy3.mp3',
    'level_up.mp3',
    'funk.mp3',
    'coin_sound.mp3',
    'rainy_run.mp3',
  ];

  late MrPeeps mrPeeps;

  @override
  Future<void>? onLoad() async {
    double screenX = size.x;
    double screenY = size.y;
    double ratio = screenY / screenX;
    print('RATIO" $ratio');
    /*if(ratio >= 0.55) {
      camera.viewport = FixedResolutionViewport(Vector2(736,414));
    }*/
    gameDataProvider = GameDataProvider();
    await images.load('tort.png');
    await images.load('peeps4.png');
    await images.load('bird.png');
    await images.load('dog.png');
    await images.load('rocket_tort.png');
    await images.load('magic_butterfly.png');
    await images.load('coin_ten.png');

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
    artifactManager = ArtifactManager();
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
      var score = gameDataProvider.currentPoints;
      var highScore = box.read('high') ?? 0;
      highScore ??= 0;
      if (score > highScore) {
        box.write('high', score);
      }
      overlays.add(GameOver.id);
      enemyManager.removeAllEnemies();
      remove(enemyManager);
      artifactManager.removeAllArtifacts();
      remove(artifactManager);
    }

    //This handles the level changes
    if (gameDataProvider.currentPoints >= levelData.data[index].endScore) {
      if(gameDataProvider.currentPoints >= levelData.data[(levelData.data.length) - 1].endScore) {
        pauseEngine();
        AudioManager.instance.stopBgm();
        AudioManager.instance.playSfx('level_up.mp3', 0.4);
        overlays.add(GameWonOverlay.id);

      } else {
        endLevel(nextLevel: index + 2);
        AudioManager.instance.stopBgm();
        AudioManager.instance.playSfx('level_up.mp3', 0.4);

      }

    }

    super.update(dt);
  }

  void endLevel({required int nextLevel}) {
    int index = nextLevel - 1;
    pauseEngine();

    level = nextLevel;
    enemyManager.removeAllEnemies();
    artifactManager.removeAllArtifacts();

    remove(mrPeeps);
    remove(enemyManager);
    remove(artifactManager);

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


        }

        pauseEngine();

        break;
    }
    super.lifecycleStateChange(state);
  }

  void resetGame() {
    //enemyManager.removeFromParent();
    //artifactManager.removeFromParent();
    //enemyManager.removeAllEnemies();
    //artifactManager.removeAllArtifacts();
    add(enemyManager);
   // add(artifactManager);
  }

  void startGamePlay() {

    loadLevelState();
    int index = savedLevel - 1;
    setParallax(index);
    add(parallaxComponent);

  //  spawnEnemies();
   // spawnArtifacts();

    //add(mrPeeps);
    //mrPeeps.changePriorityWithoutResorting(1);

  }

  void addMrPeeps() {
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

  void spawnArtifacts() {
   add(artifactManager);
    artifactManager.changePriorityWithoutResorting(3);
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

  void loadNewLevelBGM() {
    int newLevel = box.read('level') ?? 1;
    print('New Level: $newLevel');
    int levelIndex = newLevel - 1;
    print('New Level Index: $levelIndex');
    AudioManager.instance.startBgm(levelData.data[levelIndex].bgm);
    print('New Level Music: ${levelData.data[levelIndex].bgm}');
  }

}
