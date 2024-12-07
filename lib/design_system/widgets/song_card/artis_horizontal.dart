import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

class ArtistTile extends StatelessWidget {
  final String artist;
  // final String like;
  final String imageUrl;

  const ArtistTile({
    required this.artist,
    // required this.like,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 75,
          width: 75,
          color: Colors.grey,
        )
            // Image.network(imageUrl, width: 75, height: 75, fit: BoxFit.cover),
      ),
      title: Text(artist, style: TypographCol.h3),
      // subtitle: Text(like, style: TypographCol.p2,),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
      onTap: () {},
    );
  }
}
