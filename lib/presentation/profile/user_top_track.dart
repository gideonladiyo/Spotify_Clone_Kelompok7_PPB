import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/profile/user_top_track_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';

import '../music_player/music_player.dart';

class TopTracks extends StatelessWidget {
  TopTracks({super.key});
  UserTopController controller = Get.put(UserTopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
            height: 600,
            child: Obx(() {
              return controller.artists.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: controller.tracks.length,
                itemBuilder: (BuildContext context, int index) {
                  Music music = controller.tracks[index];
                  return MusicTile(music: music);
                },
              );
            })
        ),
      ),
    );
  }
}
