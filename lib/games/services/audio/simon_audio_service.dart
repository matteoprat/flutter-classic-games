import 'package:classic_games/data/simon_command.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class SimonAudioService {
  bool _isInitialized = false;
  final double initFrequency = 440.0;

  Future<void> init() async {
    await SoundGenerator.init(44100);
    SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    SoundGenerator.setFrequency(initFrequency);
    SoundGenerator.setVolume(0.5);
    _isInitialized = true;
  }

  void playNote(SimonCommand command) {
    if (_isInitialized) {
      SoundGenerator.setFrequency(command.frequency);
      SoundGenerator.play();
    }
  }

  void stopNote() {
    if (_isInitialized) {
      SoundGenerator.stop();
    }
  }

  void dispose() {
    SoundGenerator.release();
  }
}
