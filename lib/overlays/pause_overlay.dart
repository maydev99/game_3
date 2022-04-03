import 'package:flutter/material.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/overlays/hud.dart';
import 'package:provider/provider.dart';

class PauseOverlay extends StatefulWidget {
  static const id = 'PauseOverlay';
  final PeepGame gameRef;

  const PauseOverlay({Key? key, required this.gameRef}) : super(key: key);

  @override
  _PauseOverlayState createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay> {
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
                    'Paused',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                  ),
                  MaterialButton(
                    onPressed: () {
                      gameRef.overlays.remove(PauseOverlay.id);
                      gameRef.overlays.add(Hud.id);
                      gameRef.resumeEngine();
                      //AudioManager.instance.resumeBgm();

                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Resume Game'),
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
