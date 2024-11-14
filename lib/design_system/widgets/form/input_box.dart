import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

class InputBoxForm extends StatelessWidget {
  final String text;
  const InputBoxForm({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
        ),
        style: TypographCol.h5,
      ),
    );
  }
}