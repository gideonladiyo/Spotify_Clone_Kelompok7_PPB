import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/home/home_controller.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import 'package:spotify_group7/presentation/home/list_album.dart';
import 'package:spotify_group7/presentation/home/list_artist.dart';
import 'package:spotify_group7/presentation/home/list_playlist.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/spotify_logo.png",
                  width: 150,
                ),
              ),
              SizedBox(height: PaddingCol.xxxl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Today's Hits",
                  style: TypographCol.h1,
                ),
              ),
              SizedBox(height: PaddingCol.md),
              SizedBox(
                height: 200,
                child: Obx(() {
                  return controller.musicList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1,
                          ),
                          itemCount: controller.musicList.length,
                          itemBuilder: (context, index) {
                            Music music = controller.musicList[index];
                            return CustomSongCard(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MusicPlayer(music: music),
                                  ),
                                );
                              },
                              imagePath: music.songImage ?? "default_song_url",
                              title1: music.songName ?? "Name not Found",
                              title2:
                                  music.artistName ?? "Artist name not found",
                            );
                          },
                        );
                }),
              ),
              SizedBox(height: PaddingCol.xxxl),
              TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Text(
                      "Artist",
                      style: TypographCol.h2,
                    ),
                  ),
                  Tab(
                      child: Text(
                    "Album",
                    style: TypographCol.h2,
                  )),
                  Tab(
                      child: Text(
                    "Playlist",
                    style: TypographCol.h2,
                  )),
                ],
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [ListArtistHome(), ListAlbumHome(), ListPlaylist()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
