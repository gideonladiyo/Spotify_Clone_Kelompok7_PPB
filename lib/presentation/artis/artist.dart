import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/artist/artist_controller.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';

class Artis extends StatelessWidget {
  Artis artis;
  Artis({super.key, required this.artis});
  ArtistController controller = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.darkBG,
          appBar: AppBar(
            backgroundColor: AppColors.secondaryColor,
            elevation: 0,
            title: Center(
              child: Text("Profil", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: Obx(() {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(artis ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          controller.user.value?.name ?? '-',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          controller.user.value?.email ?? '-',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Followers", style: TextStyle(fontSize: 12)),
                                SizedBox(height: 5),
                                Text("${controller.user.value?.followers}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  // Mostly Played Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Mostly played",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Text(
                            "Tracks",
                            style: TypographCol.h2,
                          ),
                        ),
                        Tab(
                            child: Text(
                              "Artist",
                              style: TypographCol.h2,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 500,
                    child: TabBarView(
                      children: [
                        TopTracks(),
                        TopArtists(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })
      ),
    );
  }
}
