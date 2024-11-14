import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

class CustomSongCard extends StatelessWidget {
  final int id_song;
  final String imagePath;
  final String title1;
  final String title2;

  const CustomSongCard({
    super.key,
    required this.id_song,
    required this.imagePath,
    required this.title1,
    required this.title2
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 8,
                right: 8,
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: PaddingCol.sm,),
        Text(
          title1,
          style: TypographCol.h4,
        ),
        const SizedBox(height: PaddingCol.xs,),
        Text(
          title2,
          style: TypographCol.p2,
        )
      ],
    );
  }
}