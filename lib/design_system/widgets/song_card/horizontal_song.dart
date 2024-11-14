import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

class HorizontalSong extends StatelessWidget {
  final int id_song;
  final String imagePath;
  final String title;
  const HorizontalSong({
    super.key,
    required this.id_song,
    required this.imagePath,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  color: AppColors.secondaryColor,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                SizedBox(width: PaddingCol.lg,),
                Text(
                  title,
                  style: TypographCol.h4,
                )
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            child: Container(
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}