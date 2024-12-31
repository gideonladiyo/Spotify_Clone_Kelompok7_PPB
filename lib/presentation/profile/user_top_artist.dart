import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/controller/profile/user_top_track_controller.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import '../../data/models/artists.dart';
import '../../design_system/widgets/song_card/artis_horizontal.dart';
import '../artis/artist.dart';

class TopArtists extends StatelessWidget {
  TopArtists({super.key});
  final UserTopController controller = Get.put(UserTopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.artists.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.artists.length,
            itemBuilder: (BuildContext context, int index) {
              Artists artist = controller.artists[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ArtistTile(
                  artistViewDirections: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext builder) =>
                            ArtistView(artist: artist),
                      ),
                    );
                  },
                  artist: artist,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}