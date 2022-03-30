import 'package:layout/level/level.dart';

class LevelData {
  List<Level> data = [
    Level(
        levelId: 1,
        bg1: 'bg1_1.png',
        bg2: 'bg1_2.png',
        bg3: 'bg1_3.png',
        bg4: 'bg1_5.png',
        bgm: 'funnysong.mp3',
        endScore: 100),
    Level(
        levelId: 2,
        bg1: 'bg2_1.png',
        bg2: 'bg2_21.png',
        bg3: 'bg2_3.png',
        bg4: 'bg2_41.png',
        bgm: 'steeldrum.mp3',
        endScore: 200),
    Level(
        levelId: 3,
        bg1: 'bg2_1.png',
        bg2: 'bg1_2.png',
        bg3: 'bg2_3.png',
        bg4: 'bg1_5.png',
        bgm: 'underground.mp3',
        endScore: 300)
  ];
}
