import 'package:flame/game.dart';
import 'package:flutter/material.dart';
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
            Hud.id: (_,PeepGame gameRef) => Hud(gameRef: _peepGame)
          },

          initialActiveOverlays: const [Hud.id],
          game: _peepGame,
        ),
      )
    );
  }

}

/*
class GameScreenPage extends StatefulWidget {
  const GameScreenPage({Key? key}) : super(key: key);


  @override
  _GameScreenPageState createState() => _GameScreenPageState();
}

class _GameScreenPageState extends State<GameScreenPage> {

  //Variables and functions


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Screen'),
      ),
    );
  }
}*/
