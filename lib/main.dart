import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/design_system/styles/app_theme.dart';
import 'package:spotify_group7/presentation/splash/splash.dart';

import 'data/routes/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppRoute.routes,
      home: const SplashPage(),
    );
  }
}