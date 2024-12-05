import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

class ArtistTile extends StatelessWidget {
  final String artist;
  final String imageUrl;

  const ArtistTile({
    required this.artist,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Gambar berbentuk lingkaran dengan ukuran 100x100
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16), // Jarak antara gambar dan teks
          Expanded(
            child: Text(
              artist,
              style: TypographCol.h3,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
