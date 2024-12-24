import 'package:get/get.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/users.dart';
import 'package:spotify_group7/data/repositories/playlist/playlist_api.dart';
import 'package:spotify_group7/data/repositories/user/user_api.dart';
import '../../data/functions/token_manager.dart';
import '../../data/models/playlist.dart';

class UserController extends GetxController {
  var user = Rx<Users?>(null);
  var userPlaylist = <PlaylistModel>[].obs;

  void getUserInfo() async {
    bool isTokenValid = await TokenManager.refreshAccessToken();

    if (!isTokenValid) {
      return;
    }

    try {
      Users userData = await UserApi().getUserInfo();
      user.value = userData;

      await getUserPlaylist();
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  Future<void> createPlaylist(
      String userId, String name, String desc, bool isPublic) async {
    bool isTokenValid = await TokenManager.refreshAccessToken();

    if (!isTokenValid) {
      return;
    }
    try {
      await UserApi().createPlaylist(userId, name, desc, isPublic);
      showSnackbar(
          'Success Create Playlist!', 'You have created playlist "$name"');
    } catch (e) {
      print(e);
    }
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(title, message);
  }

  Future<void> createUserLikedSong() async {
    bool isTokenValid = await TokenManager.refreshAccessToken();

    if (!isTokenValid) {
      return;
    }

    try {
      List<Music> userSavedTrack = await UserApi().getUserSavedTracks();
      PlaylistModel likedTrackPlaylist = PlaylistModel(
        id: 'userLikedTrackPlaylist',
        authorId: user.value!.userId,
        title: 'Liked Song',
        count: "${userSavedTrack.length} Songs",
        imageUrl: user.value?.imageUrl,
        musics: userSavedTrack,
      );
      userPlaylist.add(likedTrackPlaylist);
    } catch (e) {
      print('Error creating liked song playlist: $e');
    }
  }

  Future<void> getUserPlaylist() async {
    bool isTokenValid = await TokenManager.refreshAccessToken();

    if (!isTokenValid) {
      return;
    }
    userPlaylist.value = [];
    await createUserLikedSong();

    try {
      List<String> playlistsId = await UserApi().getUserPlaylist();
      for (var playlistItem in playlistsId) {
        PlaylistModel playlist = await PlaylistApi.fetchPlaylist(playlistItem);
        userPlaylist.add(playlist);
      }
    } catch (error) {
      print('Error fetching user playlists: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }
}
