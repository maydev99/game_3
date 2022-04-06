import 'package:flame/components.dart';
import 'package:layout/game/peep_run.dart';

import 'enemy_data2.dart';

class EnemyMap {

  var gameRef = PeepGame();

  var data2 = [
    EnemyData2(
        name: 'Tort',
        imageFileName: 'tort.png',
        nFrames: 3,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        speedX: 180,
        canFly: false),
    EnemyData2(
        name: 'Bird',
        imageFileName: 'bird.png',
        nFrames: 3,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        speedX: 200,
        canFly: true),
    EnemyData2(
        name: 'Dog',
        imageFileName: 'dog.png',
        nFrames: 4,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        speedX: 220,
        canFly: false),
    EnemyData2(
        name: 'Rocket_Tort',
        imageFileName: 'rocket_tort.png',
        nFrames: 3,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        speedX: 300,
        canFly: false)
  ];
}
