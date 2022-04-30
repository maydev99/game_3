import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:layout/actors/enemy_data.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/game/peep_run.dart';

class Enemy extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef<PeepGame> {

  late final EnemyData enemyData;
  GameDataProvider gameDataProvider = GameDataProvider();

  Enemy(this.enemyData) {
    animation = SpriteAnimation.fromFrameData(
        enemyData.image,
        SpriteAnimationData.sequenced(
            amount: enemyData.nFrames,
            stepTime: enemyData.stepTime,
            textureSize: enemyData.textureSize),
    );


  }

  @override
  void onMount() {
    /*final shape = HitboxRectangle(relation: Vector2.all(0.8));
    addHitbox(shape);*/
    add(RectangleHitbox.relative(Vector2.all(1.0), parentSize: Vector2.all(55)));
    size *= 0.3;

    super.onMount();
  }


  @override
  void update(double dt) {
    position.x -= enemyData.speedX * dt;

    if(position.x < -enemyData.textureSize.x) {
      gameRef.gameDataProvider.addPoint();
      removeFromParent();
      //print('Removed Enemy');
    }



    super.update(dt);
  }

}
