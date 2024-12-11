import 'package:spotify_group7/data/models/music.dart';

class PlaylistModel {
  final String id;
  final String? title;
  final String? count;
  final String? imageUrl;
  final List<Music>? musics;

  PlaylistModel({
    required this.id,
    required this.title,
    required this.count,
    required this.imageUrl,
    List<Music>? musics,
  }) : musics = musics  ?? [];

  // Factory constructor untuk memetakan data dari JSON
  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'] ?? '',
      title: map['name'] ?? '',
      count: '${map['tracks']['total'] ?? 0} songs',
      imageUrl: map['images'][0]['url'] ?? '',
      musics: (map['tracks']['items'] as List<dynamic>?)?.map((item) {
        final track = item['track'];
        if (track != null) {
          return Music.fromMap(track);
        }
        return null;
      }).whereType<Music>().toList(),
    );
  }
}