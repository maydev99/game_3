import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/audio/audio_manager.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/overlays/pause_overlay.dart';
import 'package:provider/provider.dart';
import 'package:layout/game/game_data_provider.dart';
import '../audio/audio_manager.dart';

class Hud extends StatefulWidget {
  static const id = 'Hud';
  final PeepGame gameRef;


  // final GameDataProvider gameDataProvider = GameDataProvider();

  const Hud({Key? key, required this.gameRef}) : super(key: key);

  @override
  _HudState createState() => _HudState();
}

class _HudState extends State<Hud> {
  bool isPaused = false;
  bool hasMusicOn = true;
  var box = GetStorage();


  @override
  Widget build(BuildContext context) {
    var gameRef = widget.gameRef;
    var highScore = box.read('high');
    highScore ??= 0;

    return ChangeNotifierProvider.value(
      value: gameRef.gameDataProvider,
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ScoreDisplay(),
            pauseButton(gameRef),
            musicButton(),
            const LivesDisplay(),
            Text('High: $highScore',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22
            ),)
          ],
        ),
      ),
    );
  }

  IconButton musicButton() {
    return IconButton(
        onPressed: () {
          setState(() {
            if (hasMusicOn) {
              if(!isPaused) {
                hasMusicOn = false;
                AudioManager.instance.pauseBgm();
              }

            } else {

              if(!isPaused) {
                hasMusicOn = true;
                AudioManager.instance.resumeBgm();
              }

            }
          });
        },
        icon: hasMusicOn
            ? const Icon(
                Icons.music_note,
                color: Colors.white,
              )
            : const Icon(
                Icons.music_off,
                color: Colors.red,
              ));
  }

  TextButton pauseButton(PeepGame gameRef) {
    return TextButton(
        onPressed: () {
          if (!isPaused) {
            gameRef.pauseEngine();
            gameRef.overlays.remove(Hud.id);
            gameRef.overlays.add(PauseOverlay.id);
            AudioManager.instance.pauseBgm();
          } else {
            gameRef.resumeEngine();
            if(hasMusicOn) {
              AudioManager.instance.resumeBgm();
            }

          }

          setState(() {
            isPaused = !isPaused;
          });
        },
        child: isPaused
            ? const Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 35,
              )
            : const Icon(
                Icons.pause_circle_outline,
                color: Colors.white,
                size: 35,
              ));
  }
}

class LivesDisplay extends StatelessWidget {
  const LivesDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/peep_life.png',
        width: 35,
        height: 35,),
        Selector<GameDataProvider, int>(
          selector: (_, gameDataProvider) => gameDataProvider.currentLives,
          builder: (_, currentLives, __) {
            return Text(
              '$currentLives',
              style: const TextStyle(color: Colors.white, fontSize: 22),
            );
          },
        )
      ],
    );
  }
}

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<GameDataProvider, int>(
      selector: (_, gameDataProvider) => gameDataProvider.currentPoints,
      builder: (_, points, __) {
        return Text(
          'Score: $points',
          style: const TextStyle(color: Colors.white, fontSize: 22),
        );
      },
    );
  }
}
