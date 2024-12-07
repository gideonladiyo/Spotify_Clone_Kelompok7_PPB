import 'package:flutter/material.dart';
import 'package:spotify_group7/data/functions/api.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import '../../data/functions/token_manager.dart';
import '../../design_system/constant/list_item.dart';

import '../../data/models/album.dart';
import '../../design_system/widgets/song_card/playlist_item.dart';
import '../album/album.dart';

class ListAlbumHome extends StatefulWidget {
  @override
  State<ListAlbumHome> createState() => _ListAlbumHomeState();
}

class _ListAlbumHomeState extends State<ListAlbumHome> {
  List<Albums> albums = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() async {
    List<Albums> loadedAlbums = [];
    for (String albumId in listIdAlbum) {
      try {
        bool isTokenValid = await TokenManager.refreshAccessToken();

        if (!isTokenValid) {
          print("Failed to refresh access token. Skip album id $albumId");
          continue;
        }

        Albums albumData = await AlbumApi().fetchAlbum(albumId);
        loadedAlbums.add(albumData);
      } catch (e) {
        print('Error loading album $albumId: $e');
      }
    }

    setState(() {
      albums = loadedAlbums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisSpacing: PaddingCol.md, // Spasi antar kolom
            // mainAxisSpacing: PaddingCol.md, // Spasi antar baris
            childAspectRatio: 0.75, // Rasio aspek setiap item
          ),
          itemCount: albums.length, // Jumlah kartu yang akan ditampilkan
          itemBuilder: (context, index) {
            Albums album = albums[index];
            return CustomSongCard(
              onPressed: () {},
              imagePath: album.imageUrl,
              title1: album.title,
              title2: album.totalTracks,
            );
          },
        ),
      ),
    );
  }
}
