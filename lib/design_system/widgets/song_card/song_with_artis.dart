import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/music/music_player_controller.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:get/get.dart';
import '../../../data/models/album.dart';
import '../../../data/models/playlist.dart';

class MusicTile extends StatelessWidget {
  final Music music;
  final PlaylistModel? playlist;
  final Albums? album;
  final int? index;
  final VoidCallback? deleteTap;

  const MusicTile({
    required this.music,
    this.playlist,
    this.album,
    this.index,
    this.deleteTap,
  });

  @override
  Widget build(BuildContext context) {
    MusicController controller = Get.put(MusicController());
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          music.songImage ?? "default_image_url",
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        music.songName ?? "No music",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(music.artistName ?? "No artist"),
      trailing: deleteTap != null
          ? PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                if (value == 'delete') {
                  deleteTap?.call();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                ),
              ],
            )
          : null,
      onTap: () {
        print("Navigate to music player with this atribute:");
        if (playlist != null) {
          print(music.songName);
          print(playlist?.title ?? "no title");
          print(index);
          controller.navigateToMusicPlayer(
              music: music, playlist: playlist, idx: index);
        } else if (album != null) {
          print(music.songName);
          print(album?.title ?? "no title");
          print(index);
          controller.navigateToMusicPlayer(
              music: music, album: album, idx: index);
        }
      },
    );
  }
}
