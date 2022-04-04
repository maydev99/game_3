import 'dart:math';

import 'package:flame/components.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/actors/enemy.dart';
import 'package:layout/actors/enemy_data.dart';
import 'package:layout/game/peep_run.dart';

class EnemyManager extends Component with HasGameRef<PeepGame> {
  final List<EnemyData> _data = [];

  final Random _random = Random();
  final Timer _timer = Timer(2, repeat: true);
  var box = GetStorage();

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  void spawnRandomEnemy() {

    var score = gameRef.gameDataProvider.currentPoints;
    late int randomIndex;

    if (score < 20) {
      randomIndex = _random.nextInt(1);
    } else if (score >= 20 && score < 50) {
      randomIndex = _random.nextInt(2);
    } else if (score >= 50 && score < 200) {
      randomIndex = _random.nextInt(3);
    } else {
      randomIndex = _random.nextInt(4);
    }

    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      gameRef.size.x + 32,
      gameRef.size.y - 1,
    );

    if (enemyData.canFly) {
      List<double> heights = [
        gameRef.size.y - 200,
        gameRef.size.y - 100,
        gameRef.size.y - 30
      ];
      var randomHeight = (heights.toList()..shuffle()).first;
      enemy.position.y = randomHeight;
    }

    enemy.size = enemyData.textureSize;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    shouldRemove = false;

    if (_data.isEmpty) {
      _data.addAll([
        EnemyData(
            name: 'Tort',
            image: gameRef.images.fromCache('tort.png'),
            nFrames: 3,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 180,
            canFly: false),
        EnemyData(
            name: 'Bird',
            image: gameRef.images.fromCache('bird.png'),
            nFrames: 3,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 200,
            canFly: true),
        EnemyData(
            name: 'Dog',
            image: gameRef.images.fromCache('dog.png'),
            nFrames: 4,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 220,
            canFly: false),
        EnemyData(
            name: 'Rocket_Tort',
            image: gameRef.images.fromCache('rocket_tort.png'),
            nFrames: 3,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 300,
            canFly: false)
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = gameRef.children.whereType<Enemy>();
    for (var element in enemies) {
      element.removeFromParent();
    }
  }
}
