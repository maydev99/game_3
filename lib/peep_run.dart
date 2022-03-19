import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:layout/audio_manager.dart';
import 'package:layout/enemy_manager.dart';
import 'package:layout/game_data_provider.dart';
import 'package:layout/game_over.dart';
import 'package:layout/mr_peep.dart';

import 'hud.dart';

class PeepGame extends FlameGame with TapDetector, HasCollidables {
  late final MrPeeps mrPeeps;

  late EnemyManager enemyManager;
  late GameDataProvider gameDataProvider;

  static const _audioAssets = [
    'funnysong.mp3',
    'hurt7.wav',
    'jump14.wav',

  ];


  @override
  Future<void>? onLoad() async {
    gameDataProvider= GameDataProvider();
    await images.load('rubber_ball.png');
    await images.load('tort.png');

    await AudioManager.instance.init(_audioAssets);

    AudioManager.instance.startBgm('funnysong.mp3');



    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('bg1.png'),
        ParallaxImageData('bg2.png'),
        ParallaxImageData('bg3.png'),
        ParallaxImageData('bg5.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.9, 0),
    );

    enemyManager = EnemyManager();
    //enemyManager.changePriorityWithoutResorting(2);

    add(parallaxBackground);
    startGamePlay();


    return super.onLoad();
  }


  @override
  void update(double dt) {
    overlays.add(Hud.id);

    if(gameDataProvider.currentLives <= 0) {
      overlays.remove(Hud.id);
      overlays.add(GameOver.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();

    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    mrPeeps.jump();
  }

  void resetGame() {
    enemyManager.removeAllEnemies();
    enemyManager.removeFromParent();
    add(enemyManager);



  }

  void startGamePlay() {
   //
    // add(enemyManager);
    add(
      mrPeeps = MrPeeps()
        ..width = 50
        ..height = 50,
    );

    add(enemyManager);
    mrPeeps.changePriorityWithoutResorting(1);
    enemyManager.changePriorityWithoutResorting(2);
  }
}
