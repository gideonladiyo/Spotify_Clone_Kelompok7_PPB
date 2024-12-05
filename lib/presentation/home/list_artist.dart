import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/widgets/song_card/artis_horizontal.dart';

class ListArtistHome extends StatelessWidget {
  const ListArtistHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          ArtistTile(
            artist: "Bernadya",
            // like: "Harry Styles",
            imageUrl: "https://i.scdn.co/image/ab6761610000e5eb6d1dbc1a4a286b1ee9d40163",
          ),
          ArtistTile(
            artist: "Juicy Luicy",
            // like: "Harry Styles",
            imageUrl: "https://i.scdn.co/image/ab6761610000e5eb8a7372e657292fbcbde93caf",
          ),
          ArtistTile(
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://placehold.co/150x150",
          ),
          ArtistTile(
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://placehold.co/150x150",
          ),
          ArtistTile(
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://placehold.co/150x150",
          ),
        ],
      ),
    );
  }
}
