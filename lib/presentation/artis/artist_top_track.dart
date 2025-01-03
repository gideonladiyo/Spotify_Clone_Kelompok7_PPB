import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/artist/artist_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';

class ArtistTopTracks extends StatelessWidget {
  ArtistTopTracks({super.key});
  final ArtistController controller = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.artistTracks.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.artistTracks.length,
            itemBuilder: (BuildContext context, int index) {
              Music music = controller.artistTracks[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MusicTile(music: music),
              );
            },
          );
        }),
      ),
    );
  }
}