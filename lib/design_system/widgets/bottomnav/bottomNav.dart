import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:get/get.dart';

import '../../../controller/music/music_player_controller.dart';

class BottomNavbar extends StatefulWidget {
  final Widget home;
  final Widget search;
  final Widget playlist;
  final Widget profile;

  const BottomNavbar({
    super.key,
    required this.home,
    required this.search,
    required this.playlist,
    required this.profile
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 0;
  final MusicController musicController = Get.put(MusicController());

  List<Widget> get widgetOptions =>
      [widget.home, widget.search, widget.playlist, widget.profile];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => musicController.currentMusic.value != null
              ? GestureDetector(
            onTap: () {
              musicController.navigateToMusicPlayer(
                music: musicController.currentMusic.value!,
                playlist: musicController.currentPlaylist,
                album: musicController.currentAlbum,
                idx: musicController.currentIndex?.value,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              color: AppColors.primaryColor,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      musicController.currentMusic.value?.songImage ?? "",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          musicController.currentMusic.value?.songName ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          musicController.currentMusic.value?.artistName ?? "",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Obx(() => Icon(
                      musicController.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    )),
                    onPressed: () => musicController.togglePlay(),
                  ),
                ],
              ),
            ),
          )
              : const SizedBox()),
          SizedBox(
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
                    icon: Icon(Icons.search, size: 32), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.playlist_add_check, size: 32), label: "Playlist"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person, size: 32), label: "Profile"),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: AppColors.primaryColor,
              onTap: onTapped,
            ),
          ),
        ],
      ),
    );
  }
}