import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/audio/audio_manager.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/overlays/hud.dart';
import 'package:layout/overlays/settings_overlay.dart';
import 'package:provider/provider.dart';

class PauseOverlay extends StatefulWidget {
  static const id = 'PauseOverlay';
  final PeepGame gameRef;


  const PauseOverlay({Key? key, required this.gameRef}) : super(key: key);

  @override
  _PauseOverlayState createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay> {
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
                    'Paused',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                  ),
                  MaterialButton(
                    onPressed: () {
                      bool adsOn = box.read('ads') ?? true;
                      gameRef.overlays.remove(PauseOverlay.id);
                      gameRef.overlays.add(Hud.id);
                      gameRef.resumeEngine();
                      gameRef.addMrPeeps();

                      if(adsOn) {
                        gameRef.loadNewLevelBGM();
                        gameRef.spawnArtifacts();
                        gameRef.spawnEnemies();
                      } else {
                        AudioManager.instance.resumeBgm();
                      }

                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Resume Game'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                 Row(
                   children: [
                     IconButton(onPressed: () {
                       int lives = box.read('lives') ?? 5;
                       int score = box.read('score') ?? 0;
                       gameRef.overlays.remove(PauseOverlay.id);
                       gameRef.resetGame();
                       gameRef.gameDataProvider.setLives(lives);
                       gameRef.gameDataProvider.setPoints(score);
                       gameRef.resumeEngine();


                     }, icon: const Icon(Icons.refresh_outlined,
                       color: Colors.white,)),
                     IconButton(onPressed: () {
                       gameRef.overlays.remove(PauseOverlay.id);
                       gameRef.overlays.add(SettingsOverlay.id);

                     }, icon: const Icon(Icons.settings, color: Colors.white,))
                   ],
                 )



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
