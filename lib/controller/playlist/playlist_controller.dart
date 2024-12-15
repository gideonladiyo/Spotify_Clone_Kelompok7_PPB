import 'package:get/get.dart';
import 'package:spotify_group7/controller/home/home_controller.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/presentation/playlist/playlist.dart';

import '../../data/functions/api.dart';
import '../../data/functions/token_manager.dart';
import '../../design_system/constant/list_item.dart';

class PlaylistController extends GetxController {
  var playlists = <PlaylistModel>[].obs;
  HomeController homeController = Get.put(HomeController());

  @override
  void onInit(){
    super.onInit();
    loadAllPlaylist();
  }

  void loadAllPlaylist() async{
    List<PlaylistModel> loadedPlaylists = [];
    for (String playlistId in listIdPlaylist) {
      try {
        bool isTokenValid = await TokenManager.refreshAccessToken();
        if (!isTokenValid){
          print("Failed to refresh access token. Skip playlist id $playlistId");
          continue;
        }
        PlaylistModel playlistData = await PlaylistApi.fetchPlaylist(playlistId); 
        loadedPlaylists.add(playlistData);
      } catch (e) {
        print('Error loading playlist $playlistId: $e');
      }
    }
    playlists.value = loadedPlaylists;
  }
}