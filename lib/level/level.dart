class Level {
  int levelId;
  String bg1;
  String bg2;
  String bg3;
  String bg4;
  String bgm;
  int endScore;
  List<String> enemies;
  List<String> artifacts;

  Level(
      {required this.levelId,
      required this.bg1,
      required this.bg2,
      required this.bg3,
      required this.bg4,
      required this.bgm,
      required this.endScore,
      required this.enemies,
      required this.artifacts});
}
