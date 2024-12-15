import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/artist/artist_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';

import '../music_player/music_player.dart';

class ArtistTopTracks extends StatelessWidget {
  ArtistTopTracks({super.key});
  ArtistController controller = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
            height: 600,
            child: Obx(() {
              return controller.artistTracks.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: controller.artistTracks.length,
                itemBuilder: (BuildContext context, int index) {
                  Music music = controller.artistTracks[index];
                  return MusicTile(
                      songPlayerDirections: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext builder) {
                                return MusicPlayer(
                                    music: music,
                                    idx: index
                                );
                              }
                          ),
                        );
                      },
                      music: music
                  );
                },
              );
            })
        ),
      ),
    );
  }
}
