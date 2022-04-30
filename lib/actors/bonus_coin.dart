import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:layout/actors/mr_peep.dart';
import 'package:layout/game/peep_run.dart';


enum CoinStates {
  normal,
  hit,
}

class BonusCoin extends SpriteAnimationGroupComponent
    with CollisionCallbacks, HasGameRef<PeepGame> {
  bool isHit = false;
  final Timer _hitTimer = Timer(1);

  static final _animationMap = {
    CoinStates.normal: SpriteAnimationData.sequenced(amount: 1, stepTime: 0.1, textureSize: Vector2(256,256)),
    CoinStates.hit: SpriteAnimationData.sequenced(amount: 7, stepTime: 0.1, textureSize: Vector2(256,256), loop: false)
  };

  BonusCoin(Image image) : super.fromFrameData(image, _animationMap);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    anchor = Anchor.bottomRight;
    size = Vector2(256, 256);
    position.y = gameRef.size.y / 2;
    position.x = gameRef.size.x + 250;
    add(RectangleHitbox.relative(Vector2.all(1.0), parentSize: Vector2.all(55)));
  }

  @override
  void onMount() {
    _hitTimer.onTick = () {
      current = CoinStates.normal;
      isHit = false;

    };

    size *= 0.3;
    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= 200 * dt;

    if(position.x < -256) {
      removeFromParent();
    }

    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is MrPeeps) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    isHit = true;
    _hitTimer.start();
    if(isHit) {
      current = CoinStates.hit;
    }
  }
}
