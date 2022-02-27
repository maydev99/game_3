import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:layout/peep_run.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final peepGame = PeepGame();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(GameWidget(game: peepGame));
}



