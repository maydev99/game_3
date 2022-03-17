import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:layout/game_over.dart';
import 'package:layout/peep_run.dart';

import 'hud.dart';

PeepGame _peepGame = PeepGame();

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AppTitle',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          body: GameWidget(
            overlayBuilderMap: {
              Hud.id: (_, PeepGame gameRef) => Hud(gameRef: _peepGame),
              GameOver.id: (_, PeepGame gameRef) => GameOver(gameRef: _peepGame)
            },
            initialActiveOverlays: const [Hud.id],
            game: _peepGame,
          ),
        ));
  }
}
