import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/audio/audio_manager.dart';
import 'package:layout/actors/enemy_manager.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/overlays/game_over.dart';
import 'package:layout/actors/mr_peep.dart';
import 'package:layout/overlays/level_up_overlay.dart';
import 'package:layout/overlays/pause_overlay.dart';

import '../overlays/hud.dart';

class PeepGame extends FlameGame with TapDetector, HasCollidables {


  late EnemyManager enemyManager;
  late GameDataProvider gameDataProvider;
  final box = GetStorage();
  late ParallaxComponent levelOnePC;
  late ParallaxComponent levelTwoPC;
  int level = 1;


  static const _audioAssets = [
    'funnysong.mp3',
    'hurt7.wav',
    'jump14.wav',
    'underground.mp3',
  ];

  late MrPeeps
  mrPeeps;

  @override
  Future<void>? onLoad() async {
    gameDataProvider = GameDataProvider();
    await images.load('rubber_ball.png');
    await images.load('tort.png');
    await images.load('peeps4.png');
    await images.load('bird.png');
    await images.load('dog.png');

    await AudioManager.instance.init(_audioAssets);

    AudioManager.instance.startBgm('funnysong.mp3');

    levelOnePC = await loadParallaxComponent(
      [
        ParallaxImageData('bg1.png'),
        ParallaxImageData('bg2.png'),
        ParallaxImageData('bg35.png'),
        ParallaxImageData('bg5.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.9, 0),
    );

    levelTwoPC = await loadParallaxComponent([
      ParallaxImageData('bg2_1.png'),
      ParallaxImageData('bg2_2.png'),
      ParallaxImageData('bg2_3.png'),
      ParallaxImageData('bg2_4.png'),
    ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.9, 0),
    );



    mrPeeps = MrPeeps(images.fromCache('peeps4.png'));

    enemyManager = EnemyManager();


    add(levelOnePC);
    startGamePlay();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    overlays.add(Hud.id);

    if (gameDataProvider.currentLives <= 0) {
      overlays.remove(Hud.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
      var score = gameDataProvider.currentPoints;
      var highScore = box.read('high');
      highScore ??= 0;
      if(score > highScore) {
        box.write('high', score);
      }
      overlays.add(GameOver.id);

    }

    if(gameDataProvider.currentPoints == 100) {
      //pauseEngine();
      AudioManager.instance.stopBgm();
      overlays.add(LevelUpOverlay.id);
      level = 2;
      //remove(levelOnePC);
      remove(mrPeeps);
      //enemyManager.removeAllEnemies();
      //enemyManager.removeFromParent();
      remove(enemyManager);
      //add(levelTwoPC);





    }

    super.update(dt);
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
    if(level == 2) {
      remove(levelTwoPC);
      add(levelOnePC);
    }
    enemyManager.removeAllEnemies();
    enemyManager.removeFromParent();
    add(enemyManager);
  }

  void startGamePlay() {
    add(levelOnePC);
    add(mrPeeps);

    //add(enemyManager);
    mrPeeps.changePriorityWithoutResorting(1);
  }

  void spawnEnemies() {
    add(enemyManager);
    enemyManager.changePriorityWithoutResorting(2);
  }
}
