
import 'package:flame/extensions.dart';

/*
 * Needed for new Enemy by Level System
 * The only difference is that the imageFileName is a String, not an image.
 */
class EnemyData2 {
  final String name;
  final String imageFileName;
  final int nFrames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final bool canFly;

  EnemyData2(
      {required this.name,
      required this.imageFileName,
      required this.nFrames,
      required this.stepTime,
      required this.textureSize,
      required this.speedX,
      required this.canFly});
}