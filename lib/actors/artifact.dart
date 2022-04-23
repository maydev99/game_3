import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:layout/actors/mr_peep.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/game/peep_run.dart';

import 'artifact_model.dart';

class Artifact extends SpriteAnimationComponent
    with HasHitboxes, Collidable, HasGameRef<PeepGame> {
  late final ArtifactModel artifactModel;
  final shape = HitboxRectangle(relation: Vector2.all(0.8));
  GameDataProvider gameDataProvider = GameDataProvider();

  /*static final _animationMap = {
    ArtifactAnimationStates.coinNormal: SpriteAnimationData.sequenced(
        amount: 2, stepTime: 0.1, textureSize: Vector2(256, 256), loop: tr),
    ArtifactAnimationStates.coinHit: SpriteAnimationData.sequenced(
        amount: 7, stepTime: 0.1, textureSize: Vector2(256, 256), loop: false)
  };*/

  Artifact(this.artifactModel) {
    //Image image = Flame.images.fromCache(artifactModel.imageFileName);
    animation = SpriteAnimation.fromFrameData(
      artifactModel.image,
      SpriteAnimationData.sequenced(
          amount: artifactModel.nFrames,
          stepTime: artifactModel.stepTime,
          textureSize: artifactModel.textureSize),
    );
  }

  @override
  void onMount() {
    addHitbox(shape);
    size *= 0.3;

    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is MrPeeps) {
    removeHitbox(shape);
    //  hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position.x -= artifactModel.speedX * dt;

    if (position.x < -artifactModel.textureSize.x) {
      //gameRef.gameDataProvider.addPoint();
      removeFromParent();
      //print('Removed Enemy');
    }

    super.update(dt);
  }

  /*void hit() {
    removeHitbox(shape);

  }*/
}
