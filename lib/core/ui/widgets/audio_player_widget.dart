import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vocab/core/util/downloader.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({Key key, @required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer;
  Uri _tempAudioFile;

  _AudioPlayerWidgetState() : _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      setState(() {
        print('Audio player state: $state');
      });
    });
  }

  @override
  void dispose() async {
    await _audioPlayer.release();
    await _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: IconButton(
        icon: Icon(_getIcon()),
        onPressed: _handleControl,
        color: Colors.white,
      ),
      backgroundColor: _getColor(),
    );
  }

  void _handleControl() => _shouldPlay() ? _play() : _stop();

  bool _shouldPlay() =>
      _audioPlayer.state == null || _audioPlayer != AudioPlayerState.PLAYING;

  void _play() async {
    if (_tempAudioFile == null)
      _tempAudioFile = await Downloader.downloadFile('temp', widget.audioUrl);

    _audioPlayer.play(_tempAudioFile.path, volume: 1.0, position: Duration());
  }

  void _stop() async {
    _audioPlayer.stop();
  }

  IconData _getIcon() {
    switch (_audioPlayer.state) {
      case AudioPlayerState.PLAYING:
        return Icons.stop;
      default:
        return Icons.play_arrow;
    }
  }

  Color _getColor() {
    switch (_audioPlayer.state) {
      case AudioPlayerState.PLAYING:
        return Theme.of(context).errorColor;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}
