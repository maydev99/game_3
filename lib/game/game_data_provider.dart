import 'package:flutter/cupertino.dart';

class GameDataProvider with ChangeNotifier{

  int _lives = 5;
  int _points = 0;

  int get currentPoints => _points;
  int get currentLives => _lives;


  addPoint() {
    _points = _points + 1;
    notifyListeners();
  }

  clearPoints() {
    _points = 0;
    notifyListeners();
  }

  setLives(int life) {
    _lives = life;
    notifyListeners();
  }

  setPoints(int points) {
    _points = points;
    notifyListeners();
  }

  removeLife() {
    _lives--;
    notifyListeners();

  }

  addBonusPoints(int bonusPoints) {
    _points = currentPoints + bonusPoints;
    notifyListeners();
  }


}