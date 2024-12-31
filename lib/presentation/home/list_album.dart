import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/home/home_controller.dart';
import 'package:spotify_group7/data/functions/text_controller.dart';
import 'package:spotify_group7/design_system/widgets/song_card/playlist_item.dart';
import 'package:spotify_group7/presentation/album/album.dart';
import 'package:get/get.dart';

class ListAlbumHome extends StatelessWidget {
  ListAlbumHome({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return controller.albums.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
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