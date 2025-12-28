import 'package:just_audio/just_audio.dart';

class AudioService {
  final _bgm = AudioPlayer();

  final _tap = AudioPlayer();
  final _success = AudioPlayer();
  final _fail = AudioPlayer();

  bool musicEnabled = true;
  bool sfxEnabled = true;

  Future<void> init() async {
    await _bgm.setLoopMode(LoopMode.one);
    await _bgm.setAsset('assets/audio/music.wav');

    await _tap.setAsset('assets/audio/tap.mpeg');
    await _success.setAsset('assets/audio/success.mp3');
    await _fail.setAsset('assets/audio/lose.mpeg');
  }

  Future<void> playMusic() async {
    if (!musicEnabled) return;
    if (!_bgm.playing) {
      await _bgm.play();
    }
  }

  Future<void> stopMusic() async {
    await _bgm.stop();
  }

  Future<void> playTap() async {
    if (!sfxEnabled) return;
    await _tap.seek(Duration.zero);
    await _tap.play();
  }

  Future<void> playSuccess() async {
    if (!sfxEnabled) return;
    await _success.seek(Duration.zero);
    await _success.play();
  }

  Future<void> playFail() async {
    if (!sfxEnabled) return;
    await _fail.seek(Duration.zero);
    await _fail.play();
  }

  void setMusic(bool enabled) {
    musicEnabled = enabled;
    if (!enabled) stopMusic();
  }

  void setSfx(bool enabled) {
    sfxEnabled = enabled;
  }

  Future<void> dispose() async {
    await _bgm.dispose();
    await _tap.dispose();
    await _success.dispose();
    await _fail.dispose();
  }
}
