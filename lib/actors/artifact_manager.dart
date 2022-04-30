
import 'dart:math';

import 'package:flame/components.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/actors/artifact.dart';
import 'package:layout/actors/bonus_coin.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/level/level_data.dart';

import 'artifact_list.dart';
import 'artifact_model.dart';
import 'artifact_model2.dart';

class ArtifactManager extends Component with HasGameRef<PeepGame> {
  final List<ArtifactModel> _data = [];
  List<String> levelArtifacts = [];
  final List<ArtifactModel> artifactDataList = [];
  final Random _random = Random();
  var artifactList = ArtifactList();
  var levelData = LevelData();
  final Timer _timer = Timer(30, repeat: true);
  int level = 0;
  late int index;
  var box = GetStorage();


  ArtifactManager() {
    _timer.onTick = spawnRandomArtifact;
  }

  void spawnRandomArtifact() {
    final myBonusCoin = BonusCoin(gameRef.images.fromCache('coin_ten.png'));
    add(myBonusCoin);
  }

  @override
  void onMount() {
    //shouldRemove = false;
    level = box.read('level') ?? 1;
    index = level - 1;

    levelArtifacts = levelData.data[index].artifacts;
    // print(levelArtifacts.toString());

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
      //var image = artifactList.data[artifactIndex].image;

      var newArtifact = ArtifactModel(
          name: artifactName,
          image: gameRef.images.fromCache(imageFileName),
          nFrames: nFrames,
          stepTime: stepTime,
          textureSize: textureSize,
          speedX: speedX,
          altitude: altitude);

      artifactDataList.add(newArtifact);
      //print('ART Added**');

    }

    _data.addAll(artifactDataList);
    print('DL2: ${_data.length}');
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllArtifacts() {
    final artifacts = gameRef.children.whereType<BonusCoin>();
    for (var artifact in artifacts) {
      _data.clear();
      artifact.removeFromParent();
    }
  }
}
