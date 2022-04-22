import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/overlays/game_start_overlay.dart';
import 'package:provider/provider.dart';

class GameWonOverlay extends StatefulWidget {
  static const id = 'GameWonOverlay';
  final PeepGame gameRef;


  const GameWonOverlay({Key? key, required this.gameRef}) : super(key: key);

  @override
  _GameWonOverlayState createState() => _GameWonOverlayState();
}

class _GameWonOverlayState extends State<GameWonOverlay> {
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var gameRef = widget.gameRef;
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
                    'Congratulations!\nYou Won the Game',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                    textAlign: TextAlign.center,
                  ),
                  MaterialButton(
                    onPressed: () {
                      gameRef.pauseEngine();
                      gameRef.overlays.remove(GameWonOverlay.id);
                      gameRef.overlays.add(GameStart.id);
                      gameRef.gameDataProvider.setLives(5);
                      gameRef.gameDataProvider.setPoints(0);
                      gameRef.box.write('level', 1);
                      gameRef.box.write('high', 0);
                      gameRef.saveLevelState(1, 5, 0);
                      gameRef.startGamePlay();
                      gameRef.resumeEngine();

                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Reset Game'),
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
