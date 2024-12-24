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
  void onInit(){
    super.onInit();
    loadMusic();
  }

  void loadMusic() async{
    List<Music> loadedMusic = [];
    for (String musicId in listIdTracks){
      try{
        bool isTokenValid = await TokenManager.refreshAccessToken();

        if (!isTokenValid) {
          print("Failed to refresh access token");
          continue;
        }

        Music musicData = await MusicApi().fetchMusic(musicId);;
        loadedMusic.add(musicData);
      } catch (e) {
        print("Error load ${e}");
      }
    }
    musicList.value = loadedMusic;
    loadAlbum();
  }

  void loadAlbum() async{
    List<Albums> loadedAlbums = [];
    for (String albumId in listIdAlbum) {
      try {
        bool isTokenValid = await TokenManager.refreshAccessToken();

        if (!isTokenValid) {
          print("Failed to refresh access token. Skip album id $albumId");
          continue;
        }

        Albums albumData = await AlbumApi().fetchAlbum(albumId);
        loadedAlbums.add(albumData);
      } catch (e) {
        print('Error loading album $albumId: $e');
      }
    }
    albums.value = loadedAlbums;
    loadArtist();
  }

  void loadArtist() async {
    List<Artists> loadedArtist = [];
    for (String artistId in listIdArtists) {
      try {
        bool isTokenValid = await TokenManager.refreshAccessToken();

        if (!isTokenValid) {
          print("Failed to refresh access token. Skip artist id $artistId");
          continue;
        }
        Artists artistData = await ArtistApi().fetchArtist(artistId);
        loadedArtist.add(artistData);
      } catch (e) {
        print("Error loading artist $e");
      }
    }
    artists.value = loadedArtist;
  }
}