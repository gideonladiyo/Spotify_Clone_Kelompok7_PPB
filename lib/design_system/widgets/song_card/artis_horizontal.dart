import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

import '../../../data/models/artists.dart';

class ArtistTile extends StatelessWidget {
  final Artists artist;
  final double tileHeight; // Tambahkan parameter tinggi

  const ArtistTile({
    required this.artist,
    this.tileHeight = 100, // Default tinggi jika tidak ditentukan
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tileHeight, // Tinggi fleksibel
      width: double.infinity,
      child: Center(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Container(
            width: tileHeight - 20,
            height: tileHeight - 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(artist.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(artist.name, style: TypographCol.h3),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          onTap: () {},
        ),
      ),
    );
  }
}

