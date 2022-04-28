

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// Список плиток, показывающий все источники звука, добавленные в общий список аудио.
///
/// Аудиоисточники отображаются с помощью `ListTile` с обложкой и ссылкой на трек
class Playlist extends StatelessWidget {
  const Playlist(this._audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer;

  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>( // this was changed
      stream: _audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) return CircularProgressIndicator(); // this was added
        final sequence = state.sequence; // this was changed
        return ListView(
          children: [
            for (var i = 0; i < sequence.length; i++)
              ListTile(
                selected: i == state.currentIndex,
                leading: Image.network(sequence[i].tag.artwork),
                title: Text(sequence[i].tag.title),
                onTap: () {
                  _audioPlayer.seek(Duration.zero, index: i);
                },
              ),
          ],
        );
      },
    );
  }
}
