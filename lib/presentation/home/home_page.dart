import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import 'package:spotify_group7/presentation/home/list_album.dart';
import 'package:spotify_group7/presentation/home/list_artist.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: 300,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 128,
                  width: 300,
                  color: Colors.white,
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
                height: 250, // Tinggi tetap untuk ListView horizontal
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    CustomSongCard(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MusicPlayer(
                                      trackId: '4kMQVpke2L9tlWOINuAo07?si=93d305cb90914f44',
                                    )));
                      },
                      id_song: 1,
                      imagePath: "imagePath",
                      title1: "Kamu",
                      title2: "Coboy Junior",
                    ),
                    const SizedBox(width: 16),
                    CustomSongCard(
                      onPressed: (){},
                      id_song: 2,
                      imagePath: "imagePath",
                      title1: "Title 2",
                      title2: "Subtitle 2",
                    ),
                    const SizedBox(width: 16),
                    CustomSongCard(
                      onPressed: () {},
                      id_song: 3,
                      imagePath: "imagePath",
                      title1: "Title 3",
                      title2: "Subtitle 3",
                    ),
                    const SizedBox(width: 16),
                    CustomSongCard(
                      onPressed: () {},
                      id_song: 4,
                      imagePath: "imagePath",
                      title1: "Title 4",
                      title2: "Subtitle 4",
                    ),
                    const SizedBox(width: 16),
                    CustomSongCard(
                      onPressed: () {},
                      id_song: 5,
                      imagePath: "imagePath",
                      title1: "Title 5",
                      title2: "Subtitle 5",
                    ),
                  ],
                ),
              ),
              SizedBox(height: PaddingCol.xxxl),
              // TabBar di bawah ListView
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
                ],
              ),
              SizedBox(
                height: 500, // Tinggi tetap untuk TabBarView
                child: TabBarView(
                  children: [
                    ListArtistHome(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListAlbumHome(),
                    ),
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
