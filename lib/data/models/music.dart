import 'package:flutter/material.dart';


class Music {
  Duration? duration;
  String trackId;
  String? artistName;
  String? songName;
  String? songImage;
  String? artistImage;
  Color? songColor;
  String? audioUrl;
  String uri;

  Music({
    this.duration,
    required this.trackId,
    this.artistName,
    this.songName,
    this.songImage,
    this.artistImage,
    this.songColor,
    this.audioUrl,
    required this.uri
  });

  factory Music.fromMap(Map<String, dynamic> trackData) {
    return Music(
      trackId: trackData['id'],
      songName: trackData['name'],
      artistName: trackData['artists'][0]['name'],
      songImage: trackData['album']['images'][0]['url'],
      uri: trackData['uri'],
    );
  }
}

