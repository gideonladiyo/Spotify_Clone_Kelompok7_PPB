import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {

  final VoidCallback onPressed; 
  final String title;
  final double ? height;
  const BasicButton({
    required this.onPressed,
    super.key,
    required this.title,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80)
      ),
      onPressed: onPressed, 
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black
        ),
      )
    );
  }
}