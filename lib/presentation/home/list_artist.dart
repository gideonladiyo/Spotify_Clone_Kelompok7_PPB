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
                return GestureDetector(
                  onTap: () {
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
                  child: ArtistTile(
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
                  ),
                );
              },
            );
          })
        ),
      ),
    );
  }
}