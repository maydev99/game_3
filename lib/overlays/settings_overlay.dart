import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/overlays/game_start_overlay.dart';
import 'package:layout/overlays/pause_overlay.dart';
import 'package:provider/provider.dart';

class SettingsOverlay extends StatefulWidget {
  static const id = 'SettingsOverlay';
  final PeepGame gameRef;

  const SettingsOverlay({Key? key, required this.gameRef}) : super(key: key);

  @override
  _SettingsOverlayState createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {

  var box = GetStorage();
  bool _ads = true;

  @override
  Widget build(BuildContext context) {
    var gameRef = widget.gameRef;
    _ads = box.read('ads') ?? true;
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
                    'Settings',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                  ),
                  MaterialButton(
                    onPressed: () {
                      gameRef.pauseEngine();
                      gameRef.overlays.remove(SettingsOverlay.id);
                      gameRef.overlays.add(GameStart.id);
                      gameRef.gameDataProvider.setLives(5);
                      gameRef.gameDataProvider.setPoints(0);
                      gameRef.box.write('level', 1);
                      gameRef.box.write('high', 0);
                      gameRef.saveLevelState(1, 5, 0);
                      gameRef.startGamePlay();
                      gameRef.resumeEngine();
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: const Text('Reset Game'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  Row(
                    children: [
                      const Text('Ads',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),),
                      CupertinoSwitch(
                        value: _ads,
                        onChanged: (bool value) {
                          setState(() {
                            _ads = value;
                            box.write('ads', _ads);

                          });
                        },

                      ),
                    ],
                  ),

                  MaterialButton(
                    onPressed: () {
                      gameRef.overlays.remove(SettingsOverlay.id);
                      gameRef.overlays.add(PauseOverlay.id);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Back'),
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
