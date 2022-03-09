import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:layout/peep_run.dart';

enum PeepAnimationStates { run }

class MrPeeps extends SpriteAnimationGroupComponent with HasGameRef<PeepGame> {
  static final _animationMap = {
    PeepAnimationStates.run: SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        texturePosition: Vector2.all(24),
    )
  };

  double yMax = 0.0; //max height
  double speedY = 0.0; //peeps speed on Y axis
  final Timer _hitTimer = Timer(1);
  static const double gravity = 800;

  bool isHit = false;

  MrPeeps(Image image) : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    yMax = y;
    _hitTimer.onTick = () {
      current = PeepAnimationStates.run;
      isHit = false;
    };
    super.onMount();
  }

  @override
  void update(double dt) {
    speedY += gravity * dt;
    y += speedY * dt;

    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      current = PeepAnimationStates.run;

    }



    super.update(dt);
  }

  // Returns true if dino is on ground.
  bool get isOnGround => (y >= yMax);

  void jump() {
    if (isOnGround) {
      speedY = -300;
      print('jump');
      current = PeepAnimationStates.run;
    }
  }

/*  var spriteSheet = await images.load('peeps3.png');
  final spriteSize = Vector2(screenUnitX, screenUnitY);
  SpriteAnimationData spriteAnimationData = SpriteAnimationData.sequenced(
      amount: 3, stepTime: 0.1, textureSize: Vector2(256, 256));
  peepAnimation =
  SpriteAnimationComponent.fromFrameData(spriteSheet, spriteAnimationData)
  ..x = canvasSize.x / 8
  ..y = groundHeight
  ..size = spriteSize;*/
}
