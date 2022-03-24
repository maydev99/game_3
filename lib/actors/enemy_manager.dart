import 'dart:math';

import 'package:flame/components.dart';
import 'package:layout/actors/enemy.dart';
import 'package:layout/actors/enemy_data.dart';
import 'package:layout/game/peep_run.dart';

class EnemyManager extends Component with HasGameRef<PeepGame> {
  final List<EnemyData> _data = [];

  final Random _random = Random();

  final Timer _timer = Timer(2, repeat: true);

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  void spawnRandomEnemy() {
    final randomIndex = _random.nextInt(_data.length);
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
      /*final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;*/
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
            image: gameRef.images.fromCache('tort.png'),
            nFrames: 3,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 180,
            canFly: false),
        EnemyData(
            image: gameRef.images.fromCache('bird.png'),
            nFrames: 3,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 200,
            canFly: true),
        EnemyData(
            image: gameRef.images.fromCache('dog.png'),
            nFrames: 4,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 220,
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
      element.remove;
    }
  }
}
