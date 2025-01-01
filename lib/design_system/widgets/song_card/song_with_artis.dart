import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/music/music_player_controller.dart';
import 'package:spotify_group7/controller/profile/user_controller.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:get/get.dart';
import '../../../data/models/album.dart';
import '../../../data/models/playlist.dart';

class MusicTile extends StatelessWidget {
  final Music music;
  final PlaylistModel? playlist;
  final Albums? album;
  final int? index;

  const MusicTile({
    required this.music,
    this.playlist,
    this.album,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    MusicController controller = Get.put(MusicController());
    UserController userController = Get.put(UserController());

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
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onPressed: () => _showBottomSheet(context, controller, userController),
      ),
      onTap: () {
        if (playlist != null) {
          controller.navigateToMusicPlayer(
              music: music, playlist: playlist, idx: index);
        } else if (album != null) {
          controller.navigateToMusicPlayer(
              music: music, album: album, idx: index);
        } else {
          controller.navigateToMusicPlayer(music: music);
        }
      },
    );
  }

  void _showBottomSheet(BuildContext context, MusicController controller,
      UserController userController) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (playlist != null &&
                playlist!.authorId == userController.user.value!.userId &&
                playlist!.id != 'userLikedTrackPlaylist') ...[
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Hapus dari Playlist'),
                onTap: () async {
                  // Handle remove from playlist
                  await userController.removeTrackFromPlaylist(
                      music.uri, playlist!.id, playlist!);
                  await userController.getUserPlaylist();
                },
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add),
                title: const Text('Tambah ke Playlist lain'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddToPlaylistBottomSheet(context, userController);
                },
              ),
            ]
            else
              ListTile(
                leading: const Icon(Icons.playlist_add),
                title: const Text('Tambah ke Playlist'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddToPlaylistBottomSheet(context, userController);
                },
              ),
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: const Text('Buka Halaman Musik'),
              onTap: () {
                if (playlist != null) {
                  controller.navigateToMusicPlayer(
                      music: music, playlist: playlist, idx: index);
                } else if (album != null) {
                  controller.navigateToMusicPlayer(
                      music: music, album: album, idx: index);
                } else {
                  controller.navigateToMusicPlayer(music: music);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  void _showAddToPlaylistBottomSheet(
      BuildContext context, UserController userController) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        // ignore: invalid_use_of_protected_member
        final userPlaylists = userController.userPlaylist.value
            .where((playlist) =>
                playlist.id != 'userLikedTrackPlaylist' &&
                playlist.authorId == userController.user.value!.userId &&
                !(playlist.musics?.any((m) => m.trackId == music.trackId) ?? false))
            .toList();

        return SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.5,
          child: userPlaylists.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada playlist yang tersedia.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: userPlaylists.length,
                  itemBuilder: (context, index) {
                    final playlist = userPlaylists[index];
                    return ListTile(
                      leading: const Icon(Icons.playlist_play),
                      title: Text(playlist.title!),
                      onTap: () async {
                        await userController.addTrackToPlaylist(music.uri, playlist.id);
                        await userController.getUserPlaylist();
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
