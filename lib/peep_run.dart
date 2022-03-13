import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:layout/enemy_manager.dart';
import 'package:layout/mr_peep.dart';

import 'hud.dart';

class PeepGame extends FlameGame with TapDetector, HasCollidables {
  late final MrPeeps mrPeeps;

  late EnemyManager _enemyManager;

  @override
  Future<void>? onLoad() async {
    await images.load('rubber_ball.png');


    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('bg1.png'),
        ParallaxImageData('bg2.png'),
        ParallaxImageData('bg3.png'),
        ParallaxImageData('bg4.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.9, 0),
    );

    _enemyManager = EnemyManager();

    add(parallaxBackground);
    add(_enemyManager);
    add(
      mrPeeps = MrPeeps()
        ..width = 100
        ..height = 100,
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    overlays.add(Hud.id);
    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    mrPeeps.jump();
  }
}
