import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/widgets/form/input_box.dart';
import 'package:spotify_group7/design_system/widgets/form/input_box_hidden.dart';
import 'package:spotify_group7/design_system/widgets/song_card/artis_horizontal.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import 'package:spotify_group7/design_system/widgets/song_card/horizontal_song.dart';
// import 'package:spotify_group7/design_system/styles/image_col.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(60),
            child: Column(
              children: [
                CustomSongCard(id_song: 1, imagePath: "imagePath", title1: "title1", title2: "title2"),
                SizedBox(height: 20,),
                HorizontalSong(id_song: 2, imagePath: "imagePath", title: "title"),
                SizedBox(
                    height: 20,
                  ),
                ArtisHorizontal(id_artis: 3, title: "title", mostLike: "mostLike"),
                SizedBox(
                    height: 20,
                  ),
                SizedBox(height: 20,),
                InputBoxForm(text: "text"),
                SizedBox(height: 20,),
                InputBoxHidden(text: "text")
              ],
            )
          ),
        )
      ],
    );
  }
}
