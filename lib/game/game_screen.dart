import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:layout/overlays/game_over.dart';
import 'package:layout/overlays/game_start_overlay.dart';
import 'package:layout/game/peep_run.dart';
import 'package:layout/overlays/level_up_overlay.dart';
import 'package:layout/overlays/pause_overlay.dart';
import 'package:layout/overlays/settings_overlay.dart';

import '../overlays/hud.dart';

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
                GameStart.id: (_, PeepGame gameRef) => GameStart(gameRef: _peepGame),
                PauseOverlay.id: (_, PeepGame gameRef) => PauseOverlay(gameRef: _peepGame),
                LevelUpOverlay.id: (_,PeepGame gameRef) => LevelUpOverlay(gameRef: _peepGame),
                SettingsOverlay.id: (_,PeepGame gameRef) => SettingsOverlay(gameRef: _peepGame),
              },
              initialActiveOverlays: const [GameStart.id],
              game: _peepGame,
            ),
          )),
    );
  }
}
