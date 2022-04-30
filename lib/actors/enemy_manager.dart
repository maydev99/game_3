import 'dart:math';

import 'package:flame/components.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/actors/enemy.dart';
import 'package:layout/actors/enemy_data.dart';
import 'package:layout/actors/enemy_map.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/level/level_data.dart';

class EnemyManager extends Component with HasGameRef<PeepGame> {
  final List<EnemyData> _data = [];
  final List<EnemyData> enemyDataList = [];
  List<String> levelEnemies = [];

  final Random _random = Random();
  final Timer _timer = Timer(2, repeat: true);
  var levelData = LevelData();
  var enemyMap = EnemyMap();
  late int level;
  late int index;
  var box = GetStorage();

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  void spawnRandomEnemy() {
    levelEnemies.clear();
    enemyDataList.clear();

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
    }

    enemy.size = enemyData.textureSize;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    //shouldRemove = false;
    level = box.read('level') ?? 1;
    index = level - 1;

    levelEnemies.addAll(levelData.data[index].enemies);

    for (int i = 0; i < levelEnemies.length; i++) {
      String enemyName = levelEnemies[i];
      var enemyIndex =
          enemyMap.data2.indexWhere((element) => element.name == enemyName);
      var imageFileName = enemyMap.data2[enemyIndex].imageFileName;
      var nFrames = enemyMap.data2[enemyIndex].nFrames;
      var stepTime = enemyMap.data2[enemyIndex].stepTime;
      var textureSize = enemyMap.data2[enemyIndex].textureSize;
      var speedX = enemyMap.data2[enemyIndex].speedX;
      var canFly = enemyMap.data2[enemyIndex].canFly;


      var newEnemy = EnemyData(
          name: enemyName,
          image: gameRef.images.fromCache(imageFileName),
          nFrames: nFrames,
          stepTime: stepTime,
          textureSize: textureSize,
          speedX: speedX,
          canFly: canFly);

      enemyDataList.add(newEnemy);
    }
    _data.addAll(enemyDataList);

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
