import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';

class PeepGame extends FlameGame with TapDetector {
  SpriteAnimationComponent peepAnimation = SpriteAnimationComponent();
  double speed = 5.0;
  double speedY = 0.0;
  double yMax = 0.0;
  double jumpHeight = 0.0;
  static const double gravity = 800;
  double screenUnitX = 0.0;
  double screenUnitY = 0.0;
  double groundHeight = 0.0;

  @override
  Future<void>? onLoad() async {
    screenUnitX = canvasSize.x / 8;
    screenUnitY = canvasSize.y / 4;
    groundHeight = canvasSize.y - (screenUnitY * 1.2);
    jumpHeight = screenUnitY * 0.6;
    print(groundHeight);

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

    var spriteSheet = await images.load('peeps3.png');
    final spriteSize = Vector2(screenUnitX, screenUnitY);
    SpriteAnimationData spriteAnimationData = SpriteAnimationData.sequenced(
        amount: 3, stepTime: 0.1, textureSize: Vector2(256, 256));
    peepAnimation =
    SpriteAnimationComponent.fromFrameData(spriteSheet, spriteAnimationData)
    ..x = canvasSize.x / 8
    ..y = groundHeight
    ..size = spriteSize;



    add(parallaxBackground);
    add(peepAnimation);



    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    screenUnitX = canvasSize.x / 8;
    screenUnitY = canvasSize.y / 4;
    groundHeight = canvasSize.y - (screenUnitY * 1.2);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if(peepAnimation.y < groundHeight) {
      peepAnimation.y += speed;
    }
  }

  @override
  void onTap() {
    super.onTap();
    //peepAnimation.y = jumpHeight;
    //groundHeight = peepAnimation.y;
    print(peepAnimation.y);
    if(peepAnimation.y >= groundHeight) {
      peepAnimation.y -= screenUnitY * 1.8;
    }
  }

}
