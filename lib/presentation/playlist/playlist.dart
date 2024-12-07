import 'package:flutter/material.dart';
import 'package:spotify_group7/data/functions/token_manager.dart';
import 'package:spotify_group7/presentation/playlist/playlist_view.dart';
import '../../data/functions/api.dart';
import '../../data/models/playlist.dart';
import '../../design_system/constant/list_item.dart';
import '../../design_system/widgets/song_card/playlist_item.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<PlaylistModel> playlists = [];

  @override
  void initState() {
    super.initState();
    _loadPlaylists();
  }
  _loadPlaylists() async {
    List<PlaylistModel> loadedPlaylists = [];
    for (String playlistId in listIdPlaylist) {
      try {
        bool isTokenValid = await TokenManager.refreshAccessToken();

        if (!isTokenValid){
          print("Failed to refresh access token. Skip playlist id $playlistId");
          continue;
        }

        PlaylistModel playlistData = await PlaylistApi.fetchPlaylist(playlistId);

        loadedPlaylists.add(playlistData);
      } catch (e) {
        print('Error loading playlist $playlistId: $e');
      }
    }

    setState(() {
      playlists = loadedPlaylists;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlist"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: playlists.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaylistDetail(
                      playlist: playlist,
                    ),
                  ),
                );
              },
              child: PlaylistItem(
                title: playlist.title ?? "No title",
                count: playlist.count ?? "0 Song",
                imageUrl: playlist.imageUrl ?? 'default_image_url',
              ),
            );
          },
        ),
      ),
    );
  }
}