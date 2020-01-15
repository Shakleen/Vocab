import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';

class AudioPlayerWidget extends StatefulWidget {
  final Pronunciation pronunciation;

  const AudioPlayerWidget({Key key, @required this.pronunciation})
      : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer _audioPlayer;
  AudioPlayerState _state;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(
      mode: PlayerMode.MEDIA_PLAYER,
      playerId: widget.pronunciation.audioFileUrl,
    );
    _state = AudioPlayerState.STOPPED;
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print('Audio player state: $state');
      if (state == AudioPlayerState.COMPLETED) {
        setState(() {
          _state = state;
          _stop();
        });
      }
    });
    _audioPlayer.onAudioPositionChanged.listen((d) {
      print(d);
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
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void _handleControl() {
    switch (_state) {
      case AudioPlayerState.STOPPED:
        _play();
        break;
      default:
        _stop();
        break;
    }
  }

  void _play() async {
    setState(() {
      _state = AudioPlayerState.PLAYING;
    });

    print(widget.pronunciation.audioFileUrl);
    final int result = await _audioPlayer.play(
      widget.pronunciation.audioFileUrl,
      volume: 1.0,
      position: Duration(),
    );
    print('Result of playing audio: $result');
  }

  void _stop() async {
    setState(() {
      _state = AudioPlayerState.STOPPED;
    });

    final int result = await _audioPlayer.stop();
    print('Result of stopping audio: $result');
  }

  IconData _getIcon() {
    switch (_state) {
      case AudioPlayerState.PLAYING:
        return Icons.stop;
      default:
        return Icons.play_arrow;
    }
  }
}
