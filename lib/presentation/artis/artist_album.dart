import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/artist/artist_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import '../../data/functions/text_controller.dart';
import '../../design_system/widgets/song_card/playlist_item.dart';
import '../album/album.dart';

class ArtistAlbum extends StatelessWidget {
  ArtistAlbum({super.key});
  final ArtistController controller = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.artistAlbums.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
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
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: PlaylistItem(
                    title: truncateTitle(album.title, 24),
                    count: album.totalTracks,
                    imageUrl: album.imageUrl,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
