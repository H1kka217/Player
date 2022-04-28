

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/screens/general/playlist.dart';
import 'package:music_player/screens/general/player_buttons.dart';
import 'package:music_player/domain/audio/audio_metadata.dart';
import 'package:provider/provider.dart';
import '../domain/playlists/playlist_item.dart';
import '../services/playlists/playlists_service.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Consumer<PlaylistsService>(
            builder: (__, value, _) {
              _loadAudioSources(value.allItems);
              return Column(
                children: [
                  Expanded(child: Playlist(_audioPlayer)),
                  PlayerButtons(_audioPlayer),
                ],
              );
            },
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
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();


    _audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(
                "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3"),
            tag: AudioMetadata(
              title: "Tristram",
              artwork:
              "https://upload.wikimedia.org/wikipedia/en/3/3a/Diablo_Coverart.png",
            ),
          ),
          AudioSource.uri(
            Uri.parse(
                "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3"),
            tag: AudioMetadata(
              title: "Cerulean City",
              artwork:
              "https://upload.wikimedia.org/wikipedia/en/f/f1/Bulbasaur_pokemon_red.png",
            ),
          ),
          AudioSource.uri(
            Uri.parse(
                "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3"),
            tag: AudioMetadata(
              title: "The secret of Monkey Island - Introduction",
              artwork:
              "https://upload.wikimedia.org/wikipedia/en/a/a8/The_Secret_of_Monkey_Island_artwork.jpg",
            ),
          ),
        ],
      ),
    )
        .catchError((error) {
      // load errors: 404
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              //помогает расширить пространство
              // для дочернего виджета Row или Column
              // по главной оси (main axis)
              Expanded(
                  child:Playlist(_audioPlayer)
              ),
              PlayerButtons(_audioPlayer),
            ],
          ),
        ),
      ),
    );
  }
}
