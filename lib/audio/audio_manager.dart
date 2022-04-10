import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  AudioManager._internal();
  late AudioPool pool;

  static final AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  Future<void> init(List<String> files) async {
    FlameAudio.bgm.initialize();
    pool = await AudioPool.create('boing.mp3', minPlayers: 3, maxPlayers: 4);

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

  void playJumpSound() {
    pool.start(volume: 1);
  }

  void playSfx(String filename, double volume) {
    FlameAudio.audioCache.play(filename, volume: volume);
  }
}