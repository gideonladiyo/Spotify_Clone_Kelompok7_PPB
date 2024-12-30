import 'package:flutter/material.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';

import '../../data/models/album.dart';


class AlbumView extends StatelessWidget {
  final Albums album;
  const AlbumView({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(album.imageUrl),
            const SizedBox(height: 16.0),
            Text("Album"),
            SizedBox(
              height: 8,
            ),
            Text(
              album.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              album.totalTracks,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            album.musics == null || album.musics!.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: album.musics!.length,
                      itemBuilder: (context, index) {
                        Music music = album.musics![index];
                        return MusicTile(
                            music: music,
                            index: index,
                          album: album,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}