import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

class ArtisHorizontal extends StatelessWidget {
  final int id_artis;
  final String title;
  final String mostLike;
  const ArtisHorizontal({
    super.key,
    required this.id_artis,
    required this.title,
    required this.mostLike
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: PaddingCol.lg,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TypographCol.h4,
              ),
              Text(
                mostLike,
                style: TypographCol.p2,
              )
            ],
          )
        ],
      ),
    );
  }
}