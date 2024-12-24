import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/image_col.dart';

class PlaylistItem extends StatelessWidget {
  final String title;
  final String count;
  final String imageUrl;

  const PlaylistItem({
    Key? key,
    required this.title,
    required this.count,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl == ''
              ? Image.asset(
                AppImages.logo_lagu,
                width: double.infinity,
                fit: BoxFit.cover,
              ) : Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            count,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
    );
  }
}
