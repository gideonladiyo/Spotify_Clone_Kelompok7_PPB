import 'package:spotify_group7/data/models/artists.dart';

class Albums {
  final String title;
  final Artists artist;
  final int totalTracks;
  final String imageUrl;

  Albums({
    required this.title,
    required this.artist,
    required this.totalTracks,
    required this.imageUrl,
  });
}