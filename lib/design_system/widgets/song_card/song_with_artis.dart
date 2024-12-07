import 'package:flutter/material.dart';

class MusicTile extends StatelessWidget {
  // final String id_song;
  final String title;
  final String artist;
  final String imageUrl;

  const MusicTile({
    // required this.id_song,
    required this.title,
    required this.artist,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child:
            Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(artist),
      trailing: Icon(Icons.more_vert, color: Colors.white),
      onTap: () {},
    );
  }
}
