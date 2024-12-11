import 'package:get/get.dart';
import 'package:spotify_group7/data/functions/api.dart';
import 'package:spotify_group7/data/functions/token_manager.dart';
import 'package:spotify_group7/data/models/music.dart';

class SearchPageController extends GetxController {
  final SearchApi searchApi = SearchApi();

  var searchQuery = ''.obs;
  var musicResult = <Music>[].obs;
  var isLoading = false.obs;

  void performSearch(String query) async {
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
}
