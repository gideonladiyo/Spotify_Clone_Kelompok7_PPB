import 'package:flutter/material.dart';
import 'package:spotify_group7/core/config/appTheme.dart';
import 'package:spotify_group7/presentation/splash/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}