import 'package:get/get.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/repositories/user/user_api.dart';
import '../../data/functions/token_manager.dart';

class UserTopController extends GetxController {
  var tracks = <Music>[].obs;
  var artists = <Artists>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    getUserTopTracks();
  }

  void getUserTopTracks() async {
    isLoading.value = true;
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if (!isTokenValid) {
      return;
    }
    try {
      List<Music> musics = await UserApi().getTopTracks();
      tracks.value = musics;
      isLoading.value = false;
    } catch (e) {
      print('Error user top tracks: $e');
    }
    getUserTopArtists();
  }

  void getUserTopArtists() async{
    isLoading.value = true;
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if (!isTokenValid) {
      return;
    }
    try {
      List<Artists> loadedArtists = await UserApi().getTopArtists();
      artists.value = loadedArtists;
      isLoading.value = false;
    } catch (e) {
      print('Error user top tracks: $e');
    }
  }
}