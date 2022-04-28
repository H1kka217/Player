import 'package:music_player/domain/playlists/author.dart';
class PlaylistItem {
  final Author author;
  final String title;
  final Uri? imgworkUri;
  final Uri itemLocation;

  PlaylistItem(
      this.author,
      this.title,
      this.imgworkUri,
      this.itemLocation,
      );
}