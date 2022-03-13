import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:layout/main_menu.dart';
import 'package:wakelock/wakelock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  Wakelock.enable();
  runApp(const MainMenu());
}



