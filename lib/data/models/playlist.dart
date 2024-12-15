import 'package:spotify_group7/data/models/music.dart';

class PlaylistModel {
  final String id;
  final String authorId;
  final String? title;
  final String? count;
  final String? imageUrl;
  List<Music>? musics;

  PlaylistModel({
    required this.id,
    required this.authorId,
    required this.title,
    required this.count,
    required this.imageUrl,
    this.musics,
  });

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    final ownerId = map['owner'] != null ? map['owner']['id'] : '';
    final tracks = map['tracks'] != null ? map['tracks'] : {};
    final totalTracks = tracks['total'] ?? 0;

    return PlaylistModel(
      id: map['id'] ?? '',
      authorId: ownerId,
      title: map['name'] ?? '',
      count: '$totalTracks songs',
      imageUrl: map['images'] != null && map['images'].isNotEmpty
          ? map['images'][0]['url']
          : '',
      musics: tracks['items'] != null
          ? List<Music>.from(tracks['items']
              .where((item) => item != null && item['track'] != null)
              .map((item) => Music.fromMap(item['track'])))
          : null,
    );
  }
}