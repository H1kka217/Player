import 'package:music_player/domain/playlists/author.dart';
/// Аудио элемент
class PlaylistItem {
  /// [Author] это аудиофайла .
  final Author author;

  /// Название .
  final String title;


  /// Uri изображения, представляющего этот звуковой элемент.
  final String imgworkLocation;

  /// Uri, по которому можно найти аудио.
  final Uri itemLocation;

  PlaylistItem({
    required this.author,
    required this.title,
    this.imgworkLocation = "https://via.placeholder.com/150",
    required this.itemLocation,
  });
}