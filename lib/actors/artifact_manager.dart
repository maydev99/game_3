/*
import 'dart:math';

import 'package:flame/components.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/actors/artifact.dart';
import 'package:layout/actors/artifact_list.dart';
import 'package:layout/actors/artifact_model.dart';
import 'package:layout/game/peep_run.dart';

import '../level/level_data.dart';

class ArtifactManager extends Component with HasGameRef<PeepGame> {
  final List<ArtifactModel> _data = [];
  final List<String> levelArtifacts = [];
  final List<ArtifactModel> artifactDataList = [];
  final Random _random = Random();
  var artifactList = ArtifactList();
  var levelData = LevelData();
  final Timer _timer = Timer(10, repeat: true);
  late int level;
  late int index;
  var box = GetStorage();

  ArtifactManager() {
    _timer.onTick = spawnRandomArtifact();
  }

  spawnRandomArtifact() {
    final randomIndex = _random.nextInt(_data.length);
    final artifactData = _data.elementAt(randomIndex);
    final artifact = Artifact(artifactData);

    artifact.anchor = Anchor.bottomLeft;
    artifact.position = Vector2(
        gameRef.size.x + 32,
        gameRef.size.y - artifactData.altitude);

    artifact.size = artifactData.textureSize;
    gameRef.add(artifact);
  }

  @override
  void onMount() {
    shouldRemove = false;
    level = box.read('level') ?? 1;
    index = level - 1;
    levelArtifacts.addAll(levelData.data[index].artifacts);

    for (int i = 0; i < levelArtifacts.length; i++) {
      String artifactName = levelArtifacts[i];
      var artifactIndex = artifactList.data.indexWhere((element) =>
      element.name == artifactName);
      var imageFileName = artifactList.data[artifactIndex].imageFileName;
      var nFrames = artifactList.data[artifactIndex].nFrames;
      var stepTime = artifactList.data[artifactIndex].stepTime;
      var textureSize = artifactList.data[artifactIndex].textureSize;
      var speedX = artifactList.data[artifactIndex].speedX;
      var altitude = artifactList.data[artifactIndex].altitude;

      var newArtifact = ArtifactModel(
          name: artifactName,
          imageFileName: imageFileName,
          nFrames: nFrames,
          stepTime: stepTime,
          textureSize: textureSize,
          speedX: speedX,
          altitude: altitude);

      artifactDataList.add(newArtifact);

    }

    _data.addAll(artifactDataList);
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllArtifacts() {
    final artifacts = gameRef.children.whereType<Artifact>();
    for (var artifact in artifacts) {
      artifact.removeFromParent();
    }
  }
}
*/
