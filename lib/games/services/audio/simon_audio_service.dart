import 'package:audioplayers/audioplayers.dart';
import 'package:classic_games/data/simon_command.dart';

class SimonAudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> init() async {
    await _player.setReleaseMode(ReleaseMode.stop);
  }

  void playNote(SimonCommand command) async {
    await _player.stop();
    await _player.play(AssetSource(command.soundAsset));
  }

  void stopNote() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
