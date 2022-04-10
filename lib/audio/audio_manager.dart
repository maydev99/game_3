import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  AudioManager._internal();
  late AudioPool jumpSound;
  late AudioPool hitSound;

  static final AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  Future<void> init(List<String> files) async {
    FlameAudio.bgm.initialize();
    jumpSound = await AudioPool.create('boing.mp3', minPlayers: 3, maxPlayers: 4);
    hitSound = await AudioPool.create('chicken_scream.mp3', minPlayers: 2, maxPlayers: 3);

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
    jumpSound.start(volume: 0.4);
  }

  void playHitSound() {
    hitSound.start(volume: 0.4);
  }

  void playSfx(String filename, double volume) {
    FlameAudio.audioCache.play(filename, volume: volume);
  }
}