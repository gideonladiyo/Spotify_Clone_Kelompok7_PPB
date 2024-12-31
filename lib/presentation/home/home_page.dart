import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/home/home_controller.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import 'package:spotify_group7/presentation/home/list_album.dart';
import 'package:spotify_group7/presentation/home/list_artist.dart';
import 'package:spotify_group7/presentation/home/list_playlist.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Image.asset(
                          "assets/images/spotify_logo.png",
                          width: 120,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Hits",
                            style: TypographCol.h1.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Listen to the hottest tracks",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      child: Obx(() {
                        return controller.musicList.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                              ))
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.musicList.length,
                                itemBuilder: (context, index) {
                                  Music music = controller.musicList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: CustomSongCard(
                                      imagePath:
                                          music.songImage ?? "default_song_url",
                                      title1:
                                          music.songName ?? "Name not Found",
                                      title2: music.artistName ??
                                          "Artist name not found",
                                      music: music,
                                    ),
                                  );
                                },
                              );
                      }),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        padding: const EdgeInsets.all(4),
                        tabs: const [
                          Tab(
                            text: "Artists",
                          ),
                          Tab(
                            text: "Albums",
                          ),
                          Tab(
                            text: "Playlists",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    ListArtistHome(),
                    ListAlbumHome(),
                    ListPlaylist(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}