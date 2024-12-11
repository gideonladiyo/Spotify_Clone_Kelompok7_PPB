import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/playlist/playlist_detail_controller.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';
import '../../data/models/music.dart';
import '../../data/models/playlist.dart';
import 'package:get/get.dart';


class PlaylistDetail extends StatelessWidget {
  final PlaylistModel playlist;

  PlaylistDetail({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.title ?? "No title"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(playlist.imageUrl ?? "default_image_url"),
            const SizedBox(height: 16.0),
            Text(
              playlist.title ?? "No title",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              playlist.count ?? "0 Song",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            playlist.musics == null || playlist.musics!.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: playlist.musics!.length,
                itemBuilder: (context, index) {
                  Music music = playlist.musics![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext builder) {
                            print("Navigating to MusicPlayer with: music=${music.trackId}, playlist=${playlist?.id}, idx=$index");
                            return MusicPlayer(
                                music: music,
                                playlist: playlist,
                                idx: index
                            );
                          }
                        ),
                      );
                    },
                    child: MusicTile(
                      songPlayerDirections: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext builder) {
                                print("Navigating to MusicPlayer with: music=${music.trackId}, playlist=${playlist?.id}, idx=$index");
                                return MusicPlayer(
                                    music: music,
                                    playlist: playlist,
                                    idx: index
                                );
                              }
                          ),
                        );
                      },
                      deleteTap: () {},
                      music: music,
                    ),
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