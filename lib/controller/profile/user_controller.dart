import 'package:flutter/material.dart';
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
  var userLikedTracks = <Music>[].obs;
  RxBool isPlaylistSaved = false.obs;

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
      userLikedTracks.value = userSavedTrack;
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

  void checkPlaylistSaved(String playlistId) async{
    for (var item in userPlaylist){
      if (item.id == playlistId){
        isPlaylistSaved.value = true;
      }
    }
  }

  void musicSnackbarSuccess(String message) {
    Get.snackbar("Success!", message,
        backgroundColor: Colors.white, colorText: Colors.black);
  }

  void toggleSave(String playlistId) async {
    if (!isPlaylistSaved.value) {
      await savePlaylist(playlistId);
    } else {
      await deletePlaylist(playlistId);
    }
  }

  Future<void> savePlaylist(String playlistId) async {
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if (!isTokenValid) {
      print("Token tidak valid atau gagal diperbarui.");
      return;
    }
    try {
      await UserApi().savePlaylist(playlistId);
      musicSnackbarSuccess("Playlist berhasil disimpan");
      isPlaylistSaved.value = true;
      userPlaylist.value = [];
      print("apakah playlist disimpan: ${isPlaylistSaved.value}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePlaylist(String playlistId) async {
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if (!isTokenValid) {
      return;
    }
    try {
      await UserApi().deletePlaylist(playlistId);
      musicSnackbarSuccess("Playlist berhasil dihapus dari favorit");
      isPlaylistSaved.value = false;
      userPlaylist.value = [];
      print("apakah playlist disimpan: ${isPlaylistSaved.value}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> addTrackToPlaylist(String trackUri, String playlistId) async {
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if(!isTokenValid){
      return;
    }
    try {
      await PlaylistApi().addTrackToPlaylist(trackUri, playlistId);
      musicSnackbarSuccess("Musik berhasil ditambahkan ke playlist");
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeTrackFromPlaylist(String trackUri, String playlistId, PlaylistModel playlist) async {
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if (!isTokenValid) {
      return;
    }
    try {
      await PlaylistApi().removeTrackFromPlaylist(trackUri, playlistId);
      playlist.musics?.removeWhere((music) => music.uri == trackUri);
      musicSnackbarSuccess("Musik berhasil dihapus dari playlist");
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }
}
