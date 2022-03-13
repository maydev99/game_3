import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:layout/enemy.dart';
import 'package:layout/peep_run.dart';

class MrPeeps extends SpriteAnimationComponent with HasHitboxes, Collidable, HasGameRef<PeepGame> {
  static Vector2 gravity = Vector2(0, 600);
  Vector2 velocity = Vector2.zero();
  bool isJumping = false;
  double ground = 0.0;
  bool isHit = false;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    var spriteSheet = await Flame.images.load('peeps3.png');
    SpriteAnimationData data = SpriteAnimationData.sequenced(
        amount: 3, stepTime: 0.1, textureSize: Vector2(256, 256));
    ground = gameRef.size.y - 56;
    anchor = Anchor.center;
    animation = SpriteAnimation.fromFrameData(spriteSheet, data);
    playing = true;
    size = Vector2(128, 128);
    position = Vector2(gameRef.canvasSize.x / 8, ground);
  }

  @override
  void onMount() {
    final shape = HitboxRectangle(relation: Vector2(0.5,0.7));
    addHitbox(shape);
    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if((other is Enemy) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt - gravity * dt * dt / 2;
    velocity += gravity * dt;

    if (position.y > ground) {
      velocity = Vector2(0, 0);
      isJumping = false;
    }
  }

  void jump() {
    if (!isJumping) {
      velocity += Vector2(0, -400);
      isJumping = true;
    }
  }

  void hit() {
    print('Hit!');
  }
}
