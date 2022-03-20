import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:layout/game_over.dart';
import 'package:layout/game_start_overlay.dart';
import 'package:layout/peep_run.dart';

import 'hud.dart';

PeepGame _peepGame = PeepGame();

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
          title: 'AppTitle',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Scaffold(
            body: GameWidget(
              overlayBuilderMap: {
                Hud.id: (_, PeepGame gameRef) => Hud(gameRef: _peepGame),
                GameOver.id: (_, PeepGame gameRef) => GameOver(gameRef: _peepGame),
                GameStart.id: (_, PeepGame gameRef) => GameStart(gameRef: _peepGame)
              },
              initialActiveOverlays: const [GameStart.id],
              game: _peepGame,
            ),
          )),
    );
  }
}
