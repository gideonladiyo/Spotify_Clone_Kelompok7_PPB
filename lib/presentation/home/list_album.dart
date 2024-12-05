import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';

class ListAlbumHome extends StatelessWidget {
  final List<Map<String, dynamic>> songs = [
    {
      "id_song": 1,
      "imagePath":
          "https://via.placeholder.com/150", // Ganti dengan path atau URL gambar
      "title1": "Liked Songs",
      "title2": "128 songs"
    },
    {
      "id_song": 2,
      "imagePath": "https://via.placeholder.com/150",
      "title1": "Happiers",
      "title2": "45 songs"
    },
    {
      "id_song": 3,
      "imagePath": "https://via.placeholder.com/150",
      "title1": "Sadness",
      "title2": "83 songs"
    },
    {
      "id_song": 4,
      "imagePath": "https://via.placeholder.com/150",
      "title1": "Party",
      "title2": "21 songs"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Sesuaikan warna background
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom per baris
            // crossAxisSpacing: PaddingCol.md, // Spasi antar kolom
            // mainAxisSpacing: PaddingCol.md, // Spasi antar baris
            childAspectRatio: 0.75, // Rasio aspek setiap item
          ),
          itemCount: songs.length, // Jumlah kartu yang akan ditampilkan
          itemBuilder: (context, index) {
            final song = songs[index];
            return CustomSongCard(
              onPressed: () {},
              id_song: song["id_song"],
              imagePath: song["imagePath"],
              title1: song["title1"],
              title2: song["title2"],
            );
          },
        ),
      ),
    );
  }
}
