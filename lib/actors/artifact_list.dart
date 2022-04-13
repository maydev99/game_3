import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:layout/actors/artifact_model2.dart';

import '../game/peep_run.dart';

class ArtifactList {
  var gameRef = PeepGame();

  var data = [
    ArtifactModel2(
        name: 'Magic_Butterfly',
        imageFileName: 'magic_butterfly.png',
        nFrames: 3,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        speedX: 190,
        altitude: 200),
    ArtifactModel2(
        name: 'Coin_Ten',
        imageFileName: 'coin_ten.png',
        nFrames: 2,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        speedX: 180,
        altitude: 200)
  ];
}
