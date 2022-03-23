import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/game/game_data_provider.dart';
import 'package:layout/game/game_screen.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  Wakelock.enable();
  await GetStorage.init();
  //runApp(const MainMenu());
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GameDataProvider())],
    child: const GameScreen(),
  ));
}
