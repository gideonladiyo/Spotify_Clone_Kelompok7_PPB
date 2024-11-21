import 'package:flutter/material.dart';

class MusicTile extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;

  const MusicTile({
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
            Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(artist),
      trailing: Icon(Icons.more_vert, color: Colors.white),
      onTap: () {},
    );
  }
}
