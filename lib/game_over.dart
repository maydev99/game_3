import 'package:flutter/material.dart';
import 'package:layout/game_data_provider.dart';
import 'package:layout/peep_run.dart';
import 'package:provider/provider.dart';

class GameOver extends StatefulWidget {
  static const id = 'GameOver';
  final PeepGame gameRef;

  const GameOver({Key? key, required this.gameRef}) : super(key: key);

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
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
                    'Game Over',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                  ),
                  Selector<GameDataProvider, int>(
                    selector: (_, gameDataProvider) =>
                        gameDataProvider.currentPoints,
                    builder: (_, score, __) {
                      return Text(
                        'Final Score: $score',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      );
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      gameRef.overlays.remove(GameOver.id);
                      gameRef.resetGame();
                      gameRef.gameDataProvider.setLives(5);
                      gameRef.gameDataProvider.clearPoints();
                      gameRef.resumeEngine();
                      //gameRef.startGamePlay();

                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Play Again'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  MaterialButton(
                    onPressed: () {
                      print('Main Menu');
                      Navigator.pop(context);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Main Menu'),
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
