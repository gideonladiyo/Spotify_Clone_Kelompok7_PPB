import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';

class BottomNavbar extends StatefulWidget {
  final Widget home;
  final Widget playlist;
  final Widget histoy;
  final Widget profile;

  const BottomNavbar(
      {super.key,
      required this.home,
      required this.playlist,
      required this.histoy,
      required this.profile});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> get widgetOptions =>
      [widget.home, widget.playlist, widget.histoy, widget.home];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: widgetOptions.elementAt(selectedIndex),
      )),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          backgroundColor: AppColors.secondaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 32), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_add_check,
                  size: 32,
                ),
                label: "Playlist"),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time, size: 32), label: "History"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 32,
                ),
                label: "Profile"),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.primaryColor,
          onTap: onTapped,
        ),
      ),
    );
  }
}
