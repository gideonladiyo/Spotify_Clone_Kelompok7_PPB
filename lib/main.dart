import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_theme.dart';
import 'package:spotify_group7/presentation/home/home.dart';
import 'package:spotify_group7/presentation/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}