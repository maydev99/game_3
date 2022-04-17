import 'package:layout/level/level.dart';

class LevelData {
  List<Level> data = [
    Level(
        levelId: 1,
        bg1: 'sunrise.png',
        bg2: 'mountains.png',
        bg3: 'town.png',
        bg4: 'grass.png',
        bgm: 'rainy_run.mp3',
        endScore: 100,
        enemies: [
          'Tort',
          'Bird',
        ],
        artifacts: [
          'Coin_Ten',
          'Magic_Butterfly'
        ]),
    Level(
        levelId: 2,
        bg1: 'sunset.png',
        bg2: 'ocean_2.png',
        bg3: 'puff_clouds.png',
        bg4: 'boardwalk.png',
        bgm: 'jazzy3.mp3',
        endScore: 200,
        enemies: ['Tort', 'Bird', 'Dog'],
        artifacts: [
          'Coin_Ten'
        ]),
    Level(
        levelId: 3,
        bg1: 'sunset.png',
        bg2: 'mountains.png',
        bg3: 'puff_clouds.png',
        bg4: 'grass.png',
        bgm: 'funk.mp3',
        endScore: 300,
        enemies: ['Tort', 'Bird', 'Dog', 'Rocket_Tort'],
        artifacts: [
          'Coin_Ten',
          'Magic_Butterfly'
        ]),
    Level(
        levelId: 4,
        bg1: 'desert.png',
        bg2: 'mesas.png',
        bg3: 'sajuaros.png',
        bg4: 'dirt_road.png',
        bgm: 'rainy_run.mp3',
        endScore: 400,
        enemies: ['Tort', 'Bird', 'Dog', 'Rocket_Tort'],
        artifacts: [
          'Coin_Ten'
        ]),
    Level(
        levelId: 5,
        bg1: 'sunset.png',
        bg2: 'mesas.png',
        bg3: 'ocean_2.png',
        bg4: 'grass.png',
        bgm: 'jazzy3.mp3',
        endScore: 1000,
        enemies: [
          'Bird',
          'Dog',
          'Rocket_Tort',
        ],
        artifacts: [
          'Coin_Ten'
        ]) //Change endScore after adding new level
  ];
}
