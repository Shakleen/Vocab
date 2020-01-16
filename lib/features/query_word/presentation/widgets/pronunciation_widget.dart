import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/audio_player_widget.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/core/ui/widgets/subtitle_text.dart';

class PronunciationWidget extends StatelessWidget {
  final int index;
  final Pronunciation pronunciation;

  PronunciationWidget({
    Key key,
    @required this.index,
    @required this.pronunciation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextStyle subtitleStyle = Theme.of(context).textTheme.subtitle;
    final List<Widget> children = [
      Center(child: TitleText(text: 'Pronunciation #$index')),
    ];

    if (pronunciation.audioFileUrl != null)
      children.add(Center(
        child: AudioPlayerWidget(audioUrl: pronunciation.audioFileUrl),
      ));

    children.addAll([
      Text('Dialect(s)', style: subtitleStyle),
      Column(
        children: List.from(
          pronunciation.dialectList.map((String e) => Text(e)),
        ),
      ),
      SubtitleText(
        text: 'Phonetic Notation: ${pronunciation.phoneticNotation}',
      ),
      SubtitleText(
        text: 'Phonetic Spelling: ${pronunciation.phoneticSpelling}',
      )
    ]);

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
