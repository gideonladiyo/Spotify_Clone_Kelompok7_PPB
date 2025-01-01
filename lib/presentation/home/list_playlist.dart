import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/controller/playlist/playlist_controller.dart';
import 'package:spotify_group7/controller/profile/user_controller.dart';
import 'package:spotify_group7/data/functions/text_controller.dart';
import 'package:spotify_group7/design_system/widgets/song_card/playlist_item.dart';
import 'package:spotify_group7/presentation/playlist/playlist_view.dart';

class ListPlaylist extends StatelessWidget {
  ListPlaylist({super.key});
  final PlaylistController controller = Get.put(PlaylistController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return controller.playlists.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ))
              : GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: controller.playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = controller.playlists[index];
                    return GestureDetector(
                      onTap: () {
                        userController.checkPlaylistSaved(playlist.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext builder) =>
                                PlaylistDetail(playlist: playlist),
                          ),
                        );
                      },
                      child: PlaylistItem(
                        title: truncateTitle(playlist.title ?? "No title", 24),
                        count: playlist.count ?? "0 Songs",
                        imageUrl: playlist.imageUrl ?? "default_image_url",
                      ),
                    );
                  },
                );
        }),
      ),
    );
  }
}