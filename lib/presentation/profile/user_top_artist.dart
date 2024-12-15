import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/controller/profile/user_top_track_controller.dart';

import '../../data/models/artists.dart';
import '../../design_system/widgets/song_card/artis_horizontal.dart';
import '../artis/artist.dart';

class TopArtists extends StatelessWidget {
  TopArtists({super.key});
  UserTopController controller = Get.put(UserTopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            height: 600,
            child: Obx(() {
              return controller.artists.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: controller.artists.length,
                itemBuilder: (BuildContext context, int index) {
                  Artists artist = controller.artists[index];
                  return ArtistTile(
                    artistViewDirections: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext builder) {
                              print("Navigating to Artist page with: id=${artist.id}");
                              return ArtistView(artist: artist);
                            }
                        ),
                      );
                    },
                    artist: artist,
                  );
                },
              );
            })
        ),
      ),
    );
  }
}
