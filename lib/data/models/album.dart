import 'package:flutter/material.dart';
import 'music.dart';

class Albums {
  final String id;
  final String title;
  final String artist;
  final String totalTracks;
  final String imageUrl;
  List<Music>? musics;

  Albums({
    required this.id,
    required this.title,
    required this.artist,
    required this.totalTracks,
    required this.imageUrl,
    this.musics,
  });

  factory Albums.fromMap(Map<String, dynamic> map) {
    String artistName = map['artists'][0]['name'];

    List<Music> musicList = [];
    if (map['tracks'] != null && map['tracks']['items'] != null) {
      musicList = (map['tracks']['items'] as List).map((trackData) {
        return Music(
          trackId: trackData['id'],
          songName: trackData['name'],
          artistName: trackData['artists'][0]['name'],
          songImage: map['images'][0]['url'],
        );
      }).toList();
    }
    return Albums(
      id: map['id'],
      title: map['name'],
      artist: artistName,
      totalTracks: "${map['total_tracks']} Songs",
      imageUrl: map['images'][0]['url'],
      musics: musicList,
    );
  }
}
