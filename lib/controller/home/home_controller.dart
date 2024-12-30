import 'package:get/get.dart';
import 'package:spotify_group7/data/functions/token_manager.dart';
import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/repositories/album/album_api.dart';
import 'package:spotify_group7/data/repositories/artist/artist_api.dart';
import 'package:spotify_group7/data/repositories/music/music_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:spotify_group7/design_system/constant/list_item.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeController extends GetxController {
  AudioPlayer player = AudioPlayer();
  var musicList = <Music>[].obs;
  var albums = <Albums>[].obs;
  var artists = <Artists>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMusic();
  }

  void loadMusic() async {
    List<Music> loadedMusic = [];
    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();
      if (!isTokenValid) {
        print("Failed to refresh access token");
      }

      loadedMusic = await MusicApi().fetchAllMusics();
    } catch (e) {
      print("Error load ${e}");
    }
    musicList.value = loadedMusic;
    loadAlbum();
  }

  void loadAlbum() async {
    List<Albums> loadedAlbums = [];
    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();

      if (!isTokenValid) {
        print("Failed to refresh access token.");
      }

      loadedAlbums = await AlbumApi().fetchAllAlbum();
    } catch (e) {
      print('Error loading album: $e');
    }
    albums.value = loadedAlbums;
    loadArtist();
  }

  void loadArtist() async {
    List<Artists> loadedArtist = [];
    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();

      if (!isTokenValid) {
        print("Failed to refresh access token.");
      }
      loadedArtist = await ArtistApi().fetchAllArtist();
    } catch (e) {
      print("Error loading artist $e");
    }
    artists.value = loadedArtist;
  }
}
