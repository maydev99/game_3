
import 'package:flame/components.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/actors/bonus_coin.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/level/level_data.dart';


class ArtifactManager extends Component with HasGameRef<PeepGame> {

  List<String> levelArtifacts = [];
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
      artifact.removeFromParent();
    }
  }
}
