import 'package:flutter/material.dart';
import 'package:spotify_group7/data/functions/api.dart';
import 'package:spotify_group7/design_system/widgets/song_card/artis_horizontal.dart';

import '../../data/functions/token_manager.dart';
import '../../data/models/artists.dart';
import '../../design_system/constant/list_item.dart';

class ListArtistHome extends StatefulWidget {
  const ListArtistHome({super.key});

  @override
  State<ListArtistHome> createState() => _ListArtistHomeState();
}

class _ListArtistHomeState extends State<ListArtistHome> {
  List<Artists> artists = [];

  @override
  void initState() {
    super.initState();
    _loadArtist();
  }

  _loadArtist() async {
    List<Artists> loadedArtist = [];
    for (String artistId in listIdArtists) {
      try {
        bool isTokenValid = await TokenManager.refreshAccessToken();

        if (!isTokenValid) {
          print("Failed to refresh access token. Skip artist id $artistId");
          continue;
        }

        Artists artistData = await ArtistApi().fetchArtist(artistId);
        loadedArtist.add(artistData);
      } catch (e) {
        print("Error loading artist $e");
      }
    }

    setState(() {
      artists = loadedArtist;
    });
  }


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