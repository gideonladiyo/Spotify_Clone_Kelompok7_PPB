import 'package:spotify_group7/data/models/artists.dart';

class Albums {
  final String id;
  final String title;
  final String artist;
  final String totalTracks;
  final String imageUrl;

  Albums({
    required this.id,
    required this.title,
    required this.artist,
    required this.totalTracks,
    required this.imageUrl,
  });

  factory Albums.fromMap(Map<String, dynamic> map) {
    return Albums(
        id: map['id'],
        title: map['name'],
        artist: map['artists'][0]['name'],
        totalTracks: "${map['tracks']['total']} Songs",
        imageUrl: map['images'][0]['url']
    );
  }
}