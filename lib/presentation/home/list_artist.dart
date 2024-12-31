import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/widgets/song_card/artis_horizontal.dart';
import 'package:spotify_group7/presentation/artis/artist.dart';
import '../../controller/home/home_controller.dart';
import '../../data/models/artists.dart';
import 'package:get/get.dart';

class ListArtistHome extends StatelessWidget {
  ListArtistHome({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Obx(() {
          return controller.artists.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ))
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.artists.length,
                  itemBuilder: (BuildContext context, int index) {
                    Artists artist = controller.artists[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext builder) =>
                                ArtistView(artist: artist),
                          ),
                        );
                      },
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