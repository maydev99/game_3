import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:layout/actors/artifact_model.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/game/peep_run.dart';

class Artifact extends SpriteAnimationComponent with HasHitboxes, Collidable, HasGameRef<PeepGame> {

  late final ArtifactModel artifactModel;
  GameDataProvider gameDataProvider = GameDataProvider();

  Artifact(this.artifactModel) {
    animation = SpriteAnimation.fromFrameData(
      gameRef.images.fromCache(artifactModel.imageFileName),
      SpriteAnimationData.sequenced(
          amount: artifactModel.nFrames,
          stepTime: artifactModel.stepTime,
          textureSize: artifactModel.textureSize),
    );


  }

  @override
  void onMount() {
    final shape = HitboxRectangle(relation: Vector2.all(0.8));
    addHitbox(shape);
    size *= 0.3;

    super.onMount();
  }


  @override
  void update(double dt) {
    position.x -= artifactModel.speedX * dt;

    if(position.x < -artifactModel.textureSize.x) {
      //gameRef.gameDataProvider.addPoint();
      removeFromParent();
      //print('Removed Enemy');
    }



    super.update(dt);
  }

}