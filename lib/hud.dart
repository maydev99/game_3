import 'package:flutter/material.dart';
import 'package:layout/peep_run.dart';
import 'package:provider/provider.dart';
import 'package:layout/game_data_provider.dart';

class Hud extends StatefulWidget {
  static const id = 'Hud2';
  final PeepGame gameRef;

  // final GameDataProvider gameDataProvider = GameDataProvider();

  const Hud({Key? key, required this.gameRef}) : super(key: key);

  @override
  _HudState createState() => _HudState();
}

class _HudState extends State<Hud> {
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    var gameRef = widget.gameRef;
    return ChangeNotifierProvider.value(
      value: gameRef.gameDataProvider,
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Selector<GameDataProvider, int>(
              selector: (_, gameDataProvider) => gameDataProvider.currentPoints,
              builder: (_, points, __) {
                return Text(
                  'Score: $points',
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                );
              },
            ),
            TextButton(
                onPressed: () {
                  if (!isPaused) {
                    gameRef.pauseEngine();
                  } else {
                    gameRef.resumeEngine();
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
                      )),
            Selector<GameDataProvider, int>(
              selector: (_, gameDataProvider) => gameDataProvider.lives,
              builder: (_, lives, __) {
                return Text(
                  'Lives: $lives',
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
