import 'package:flutter/material.dart';
import 'package:spotify_group7/data/models/music.dart';

class MusicTile extends StatelessWidget {
  final VoidCallback songPlayerDirections;
  final VoidCallback deleteTap;
  final Music music;

  const MusicTile({
    required this.songPlayerDirections,
    required this.deleteTap,
    required this.music,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          music.songImage ?? "default_image_url",
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        music.songName ?? "No music",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(music.artistName ?? "No artist"),
      trailing: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onSelected: (value) {
          if (value == 'delete') {
            deleteTap();
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'delete',
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete'),
            ),
          ),
        ],
      ),
      onTap: songPlayerDirections,
    );
  }
}
