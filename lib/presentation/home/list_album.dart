import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/home/home_controller.dart';
import 'package:spotify_group7/data/functions/text_controller.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import 'package:spotify_group7/design_system/widgets/song_card/playlist_item.dart';
import 'package:spotify_group7/presentation/album/album.dart';
import 'package:spotify_group7/presentation/playlist/playlist_view.dart';
import '../../data/models/album.dart';
import 'package:get/get.dart';

class ListAlbumHome extends StatelessWidget {
  ListAlbumHome({super.key});
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return controller.albums.isEmpty
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
                  itemCount: controller.albums.length,
                  itemBuilder: (context, index) {
                    final album = controller.albums[index];
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
    );
  }
}
