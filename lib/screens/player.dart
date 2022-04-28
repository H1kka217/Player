
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/screens/general/playlist.dart';
import 'package:music_player/screens/general/player_buttons.dart';
import 'package:music_player/domain/audio/audio_metadata.dart';
import '../domain/playlists/playlist_item.dart';



/// Внизу страницы есть [PlayerButtons], а остальные
/// стр. заполненs виджетом [PLaylist].

class Player extends StatelessWidget {
  final AudioPlayer _audioPlayer;
  final List<PlaylistItem> _playlist;

  Player(this._audioPlayer, this._playlist, {Key? key}) : super(key: key) {
    if (!_audioPlayer.playing) _loadAudioSources(_playlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: Playlist(_audioPlayer)),
              PlayerButtons(_audioPlayer),
            ],
          ),
        ),
      ),
    );
  }


  void _loadAudioSources(List<PlaylistItem> playlist) {
    _audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: playlist
            .map(
              (item) => AudioSource.uri(
            item.itemLocation,
            tag: AudioMetadata(
                title: item.title, artwork: item.imgworkUri.toString()),
          ),
        )
            .toList(),
      ),
    )
        .catchError((error) {
      print("An error occured $error");
    });
  }
}

