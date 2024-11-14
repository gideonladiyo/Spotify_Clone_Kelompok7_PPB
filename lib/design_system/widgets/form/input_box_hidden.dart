import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';

class InputBoxHidden extends StatelessWidget {
  final String text;
  const InputBoxHidden({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility_off),
            onPressed: (){
              
            },
          )
        ),
        style: TypographCol.h5,
      ),
    );
  }
}