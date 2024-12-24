import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/widgets/bottomnav/bottomNav.dart';
import 'package:spotify_group7/presentation/home/home_page.dart';
import 'package:spotify_group7/presentation/playlist/playlist.dart';
import 'package:spotify_group7/presentation/profile/profile.dart';
import 'package:spotify_group7/presentation/search/search_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomNavbar(
          home: HomePage(),
          search: SearchPage(),
          playlist: Playlist(),
          profile: Profile()),
    );
  }
}
