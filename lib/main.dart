import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:layout/game_data_provider.dart';
import 'package:layout/main_menu.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  Wakelock.enable();
  //runApp(const MainMenu());
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GameDataProvider())],
    child: const MainMenu(),
  ));
}
