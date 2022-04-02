import 'package:layout/level/level.dart';

class LevelData {
  List<Level> data = [
    Level(
        levelId: 1,
        bg1: 'sunrise.png',
        bg2: 'mountains.png',
        bg3: 'town.png',
        bg4: 'grass.png',
        bgm: 'funnysong.mp3',
        endScore: 100),
    Level(
        levelId: 2,
        bg1: 'sunset.png',
        bg2: 'ocean_2.png',
        bg3: 'puff_clouds.png',
        bg4: 'boardwalk.png',
        bgm: 'steeldrum.mp3',
        endScore: 200),
    Level(
        levelId: 3,
        bg1: 'sunset.png',
        bg2: 'mountains.png',
        bg3: 'puff_clouds.png',
        bg4: 'grass.png',
        bgm: 'funnysong.mp3',
        endScore: 300),
    Level(
        levelId: 4,
        bg1: 'desert.png',
        bg2: 'mesas.png',
        bg3: 'sajuaros.png',
        bg4: 'dirt_road.png',
        bgm: 'funnysong.mp3',
        endScore: 1000) //Change endScore after adding new level
  ];
}
