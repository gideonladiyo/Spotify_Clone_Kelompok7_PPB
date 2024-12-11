import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/home/home_controller.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
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
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          return controller.albums.isEmpty ? const Center(child: CircularProgressIndicator(),)
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.albums.length,
            itemBuilder: (context, index) {
              Albums album = controller.albums[index];
              return CustomSongCard(
                onPressed: () {},
                imagePath: album.imageUrl,
                title1: album.title,
                title2: album.totalTracks,
              );
              },);
        })
      ),
    );
  }
}
