import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/overlays/hud.dart';
import 'package:provider/provider.dart';

class GameStart extends StatefulWidget {
  static const id = 'GameStart';
  final PeepGame gameRef;

  const GameStart({Key? key, required this.gameRef}) : super(key: key);

  @override
  _GameStartState createState() => _GameStartState();
}

class _GameStartState extends State<GameStart> {
  var box = GetStorage();


  @override
  void initState() {
    super.initState();
    //widget.gameRef.saveLevelState(1, 10, 95); //For testing setup (Level,Lives,Points)
    var ads = box.read('ads');
    if(ads == null) {
      box.write('ads', true);
    }

    widget.gameRef.loadNewLevelBGM();


  }

  @override
  Widget build(BuildContext context) {
    var gameRef = widget.gameRef;
    //print('SIZE: ${gameRef.size.x} X ${gameRef.size.y}');
    return ChangeNotifierProvider.value(
      value: gameRef.gameDataProvider,
      child: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withOpacity(0.5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    'Peep Run',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                  ),


                  MaterialButton(
                    onPressed: () {
                      gameRef.overlays.remove(GameStart.id);
                      gameRef.overlays.add(Hud.id);
                      gameRef.loadLevelState();
                      gameRef.startGamePlay();
                      gameRef.addMrPeeps();
                      gameRef.spawnEnemies();
                      gameRef.spawnArtifacts();


                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Start Game'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
