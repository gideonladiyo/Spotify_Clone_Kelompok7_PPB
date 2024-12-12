import 'package:get/get.dart';
import 'package:spotify_group7/data/functions/api.dart';
import 'package:spotify_group7/data/functions/token_manager.dart';
import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';

class SearchPageController extends GetxController {
  final SearchApi searchApi = SearchApi();

  var searchQuery = ''.obs;
  var musicResult = <Music>[].obs;
  var playlistResult = <PlaylistModel>[].obs;
  var albumResult = <Albums>[].obs;
  var artistResult = <Artists>[].obs;
  var isLoading = false.obs;
  var selectedCategory = ''.obs;

  void searchTracks(String query) async {
    if (query.isEmpty) {
      musicResult.clear();
      return;
    }
    searchQuery.value = query;
    isLoading.value = true;
    print("query : ${searchQuery.value}");

    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();

      if(!isTokenValid) {
        print("Failed to refress access token");
        return;
      }
      List<Music> musicData = await searchApi.searchTracks(query);
      musicResult.assignAll(musicData);
      isLoading.value = false;
    } catch (e) {
      print("Failed Search");
    }
  }

  void searchPlaylist(String query) async {
    if (query.isEmpty) {
      playlistResult.clear();
      return;
    }
    searchQuery.value = query;
    isLoading.value = true;
    print("query : ${searchQuery.value}");

    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();

      if (!isTokenValid) {
        print("Failed to refress access token");
        return;
      }
      List<PlaylistModel> playlistData = await searchApi.searchPlaylist(query);
      playlistResult.assignAll(playlistData);
      isLoading.value = false;
    } catch (e) {
      print("Failed Search");
    }
  }

  void searchArtist(String query) async {
    if (query.isEmpty) {
      musicResult.clear();
      return;
    }
    searchQuery.value = query;
    isLoading.value = true;
    print("query : ${searchQuery.value}");

    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();

      if (!isTokenValid) {
        print("Failed to refresh access token");
        return;
      }
      List<Artists> artistData = await searchApi.searchArtist(query);
      artistResult.assignAll(artistData);
      isLoading.value = false;
    } catch (e) {
      print("Failed Search");
    }
  }

  void searchAlbum(String query) async {
    if (query.isEmpty) {
      albumResult.clear();
      return;
    }
    searchQuery.value = query;
    isLoading.value = true;
    print("query : ${searchQuery.value}");

    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();

      if (!isTokenValid) {
        print("Failed to refress access token");
        return;
      }
      List<Albums> albumData = await searchApi.searchAlbum(query);
      albumResult.assignAll(albumData);
      isLoading.value = false;
    } catch (e) {
      print("Failed Search");
    }
  }
}
