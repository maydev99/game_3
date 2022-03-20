import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  AudioManager._internal();

  static final AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  Future<void> init(List<String> files) async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(files);
  }

  void startBgm(String filename) {
    FlameAudio.bgm.play(filename, volume: 0.4);
  }

  void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  void resumeBgm() {
    FlameAudio.bgm.resume();
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }

  void playSfx(String filename, double volume) {
    FlameAudio.audioCache.play(filename, volume: volume);
  }
}