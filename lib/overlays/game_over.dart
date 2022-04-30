import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/game/peep_run.dart';
import 'package:provider/provider.dart';

class GameOver extends StatefulWidget {
  static const id = 'GameOver';
  final PeepGame gameRef;

  const GameOver({Key? key, required this.gameRef}) : super(key: key);

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  late int highScore;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var gameRef = widget.gameRef;
    highScore = box.read('high');


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
                            const TextStyle(color: Colors.white, fontSize: 26),
                      );
                    },
                  ),
                  Text('High Score: $highScore',
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 18
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        int lives = box.read('lives') ?? 5;
                        int score = box.read('score') ?? 0;
                        gameRef.overlays.remove(GameOver.id);
                        gameRef.resetGame();
                        gameRef.gameDataProvider.setLives(lives);
                        gameRef.gameDataProvider.setPoints(score);
                        gameRef.spawnArtifacts();
                        gameRef.resumeEngine();


                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: const Text('Play Again'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
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
