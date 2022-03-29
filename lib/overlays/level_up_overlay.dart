import 'package:flutter/material.dart';
import 'package:layout/audio/audio_manager.dart';
import 'package:layout/game/peep_run.dart';
import 'package:provider/provider.dart';

class LevelUpOverlay extends StatefulWidget {
  static const id = 'LevelUpOverlay';
  final PeepGame gameRef;


  const LevelUpOverlay({Key? key, required this.gameRef}) : super(key: key);

  @override
  _LevelUpOverlayState createState() => _LevelUpOverlayState();
}

class _LevelUpOverlayState extends State<LevelUpOverlay> {
  //Variables and functions

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
                    'Level 2',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                  ),
                  const Text(
                    '-Level Bonus +5 Lives\n-25 Bonus Points',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.yellow),
                  ),

                  MaterialButton(
                    onPressed: () {
                      gameRef.overlays.remove(LevelUpOverlay.id);
                      int curLives = gameRef.gameDataProvider.currentLives;
                      gameRef.gameDataProvider.setLives(curLives + 5);
                      gameRef.gameDataProvider.addBonusPoints(25);
                      gameRef.startGamePlay();
                      gameRef.resumeEngine();
                      gameRef.spawnEnemies();
                      gameRef.resumeEngine();


                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Continue'),
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
