import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/artist/artist_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';

import '../../data/functions/text_controller.dart';
import '../../design_system/widgets/song_card/playlist_item.dart';
import '../album/album.dart';
import '../music_player/music_player.dart';

class ArtistAlbum extends StatelessWidget {
  ArtistAlbum({super.key});
  ArtistController controller = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
            height: 600,
            child: Obx(() {
              return controller.artistAlbums.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: controller.artistAlbums.length,
                itemBuilder: (context, index) {
                  final album = controller.artistAlbums[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext builder) =>
                              AlbumView(album: album),
                        ),
                      );
                    },
                    child: PlaylistItem(
                      title: truncateTitle(album.title, 24),
                      count: album.totalTracks,
                      imageUrl: album.imageUrl,
                    ),
                  );
                },
              );
            }),
        ),
      ),
    );
  }
}
