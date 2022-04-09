import 'package:flame/components.dart';
import 'package:layout/actors/artifact_model.dart';
import 'package:layout/game/peep_run.dart';


class ArtifactList {
  var gameRef = PeepGame();

  var data = [

    ArtifactModel(
        name: 'Magic_Butterfly',
        imageFileName: 'magic_butterfly.png',
        nFrames: 3,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        speedX: 190,
        altitude: 200)
  ];
}
