import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:layout/enemy_manager.dart';
import 'package:layout/game_data_provider.dart';
import 'package:layout/game_over.dart';
import 'package:layout/mr_peep.dart';

import 'hud.dart';

class PeepGame extends FlameGame with TapDetector, HasCollidables {
  late final MrPeeps mrPeeps;

  late EnemyManager enemyManager;
  late GameDataProvider gameDataProvider;


  @override
  Future<void>? onLoad() async {
    gameDataProvider= GameDataProvider();
    await images.load('rubber_ball.png');
    //gameDataProvider.clearPoints();



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

    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    mrPeeps.jump();
  }

  void resetGame() {
   // overlays.remove(GameOver.id);
    //gameDataProvider.clearPoints();
    //mrPeeps.removeFromParent();
    enemyManager.removeAllEnemies();
    enemyManager.removeFromParent();
   // gameRef.gameDataProvider.setLives(5);
    //enemyManager.removeAllEnemies();
    //resumeEngine();
   // gameRef.enemyManager.add(gameRef.enemyManager);
    add(enemyManager);


  }

  void startGamePlay() {
    add(enemyManager);
    add(
      mrPeeps = MrPeeps()
        ..width = 100
        ..height = 100,
    );
  }
}
