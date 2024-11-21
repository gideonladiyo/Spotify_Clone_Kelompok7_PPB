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
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://via.placeholder.com/50",
          ),
          ArtistTile(
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://via.placeholder.com/50",
          ),
          ArtistTile(
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://via.placeholder.com/50",
          ),
          ArtistTile(
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://via.placeholder.com/50",
          ),
          ArtistTile(
            artist: "Matilda",
            // like: "Harry Styles",
            imageUrl: "https://via.placeholder.com/50",
          ),
        ],
      ),
    );
  }
}
