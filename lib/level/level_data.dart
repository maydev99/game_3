import 'package:layout/level/level.dart';

class LevelData {
  List<Level> data = [
    Level(
        levelId: 1,
        bg1: 'sunrise.png',
        bg2: 'mountains.png',
        bg3: 'town.png',
        bg4: 'grass.png',
        bgm: 'jazzy.mp3',
        endScore: 10,
        enemies: [
          'Tort',
          'Bird',
        ]),
    Level(
        levelId: 2,
        bg1: 'sunset.png',
        bg2: 'ocean_2.png',
        bg3: 'puff_clouds.png',
        bg4: 'boardwalk.png',
        bgm: 'jazzy.mp3',
        endScore: 200,
        enemies: ['Tort', 'Bird', 'Dog']),
    Level(
        levelId: 3,
        bg1: 'sunset.png',
        bg2: 'mountains.png',
        bg3: 'puff_clouds.png',
        bg4: 'grass.png',
        bgm: 'funnysong.mp3',
        endScore: 300,
        enemies: ['Tort', 'Bird', 'Dog', 'Rocket_Tort']),
    Level(
        levelId: 4,
        bg1: 'desert.png',
        bg2: 'mesas.png',
        bg3: 'sajuaros.png',
        bg4: 'dirt_road.png',
        bgm: 'jazzy.mp3',
        endScore: 400, 
        enemies: ['Tort', 'Bird', 'Dog', 'Rocket_Tort']),
    Level(
        levelId: 5,
        bg1: 'sunset.png',
        bg2: 'mesas.png',
        bg3: 'ocean_2.png',
        bg4: 'grass.png',
        bgm: 'funnysong.mp3',
        endScore: 1000,
        enemies: [
          'Bird',
          'Dog',
          'Rocket_Tort'
        ]) //Change endScore after adding new level
  ];
}
