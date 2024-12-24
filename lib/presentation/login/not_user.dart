import 'package:flutter/material.dart';

class NotUser extends StatelessWidget {
  const NotUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Text(
            "You Can't Access the Feature because it's not your client ID!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),
          ),
        ),
      ),
    );
  }
}
