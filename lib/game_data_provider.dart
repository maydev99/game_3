import 'package:flutter/cupertino.dart';

class GameDataProvider with ChangeNotifier{
  int get currentPoints => _points;
  int _points = 0;
  int _lives = 0;

  addPoint() {
    _points++;
    notifyListeners();
  }

  clearPoints() {
    _points = 0;
    notifyListeners();
  }

  setLives(int lives) {
    _lives = lives;
    notifyListeners();
  }

  removeLife() {
    _lives--;
    notifyListeners();

  }


}