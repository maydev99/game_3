
import 'package:flame/extensions.dart';

// This class stores all the data
// necessary for creation of an enemy.
class ArtifactModel2 {
  final String name;
  final String imageFileName;
  final int nFrames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final int altitude;

  const ArtifactModel2({
    required this.name,
    required this.imageFileName,
    required this.nFrames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.altitude,
  });
}