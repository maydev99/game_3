import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/services.dart';
import 'package:layout/actors/bonus_coin.dart';
import 'package:layout/actors/enemy.dart';
import 'package:layout/audio/audio_manager.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/game/peep_run.dart';

import 'artifact.dart';

enum PeepAnimationStates {
  run,
  hit,
}

class MrPeeps extends SpriteAnimationGroupComponent<PeepAnimationStates>
    with CollisionCallbacks, HasGameRef<PeepGame> {
  static Vector2 gravity = Vector2(0, 600);
  Vector2 velocity = Vector2.zero();
  bool isJumping = false;
  double ground = 0.0;
  bool isHit = false;
  final Timer _hitTimer = Timer(1);
  final GameDataProvider gameDataProvider = GameDataProvider();

  static final _animationMap = {
    PeepAnimationStates.run: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2(256,256),


    ),
    PeepAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2(256,256),
      texturePosition: Vector2((3)* 256,0),
    ),
  };

  MrPeeps(Image image)
      :super.fromFrameData(image, _animationMap);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    ground = gameRef.size.y - 56;
    anchor = Anchor.center;
    size = Vector2(128, 128);
    position = Vector2(gameRef.canvasSize.x / 8, ground);
  }

  @override
  void onMount() {
    add(RectangleHitbox.relative(Vector2.all(1.0), parentSize: Vector2.all(90)));

    _hitTimer.onTick = () {
      current = PeepAnimationStates.run;
      isHit = false;
    };

    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

    if ((other is Enemy) && (!isHit)) {
      hit();
    }

    if ((other is BonusCoin) && (!isHit)) {
      Future.delayed(const Duration(milliseconds: 600)).then((_){
        other.removeFromParent();
      });
      bonus();
    }
    super.onCollision(intersectionPoints, other);
  }


  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt - gravity * dt * dt / 2;
    velocity += gravity * dt;

    if (position.y > ground) {
      velocity = Vector2(0, 0);
      isJumping = false;
    }

    // gameDataProvider.currentLives;

    _hitTimer.update(dt);
  }

  void jump() {
    if (!isJumping) {
      velocity += Vector2(0, -400);
      HapticFeedback.mediumImpact();
      AudioManager.instance.playJumpSound();
      isJumping = true;
    }
  }

  void hit() {
    isHit = true;
    _hitTimer.start();
    current = PeepAnimationStates.hit;
    if (isHit) {
      HapticFeedback.heavyImpact();
      AudioManager.instance.playHitSound();
      gameRef.gameDataProvider.removeLife();
    }
  }

  void bonus() {
    isHit = true;
    _hitTimer.start();
    if(isHit) {
      AudioManager.instance.playSfx('coin_sound.mp3', 0.5);
      gameRef.gameDataProvider.addBonusPoints(10);
      gameRef.artifactManager.removeAllArtifacts();
    }
  }
}
