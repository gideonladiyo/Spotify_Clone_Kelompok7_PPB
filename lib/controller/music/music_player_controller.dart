import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/controller/profile/user_controller.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/repositories/music/music_api.dart';
import 'package:spotify_group7/data/functions/token_manager.dart';
import 'package:just_audio/just_audio.dart';

class MusicController extends GetxController {
  final player = AudioPlayer();
  final Rx<Music?> currentMusic = Rx<Music?>(null);
  final RxBool isPlaying = false.obs;
  final RxBool isPlayerVisible = false.obs;
  final RxBool isSongLiked = false.obs;

  PlaylistModel? currentPlaylist;
  Albums? currentAlbum;
  RxInt? currentIndex;

  UserController userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    _setupPlayerListeners();
  }

  void togglePlay() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  void navigateToMusicPlayer({
    required Music music,
    PlaylistModel? playlist,
    Albums? album,
    int? idx,
  }) {
    if (isPlaying.value){
      if (currentMusic.value!.trackId != music.trackId){
        playMusic(music, playlist: playlist, album: album, idx: idx);
      }
    } else{
      playMusic(music, playlist: playlist, album: album, idx: idx);
    }
    Get.toNamed('/music-player');
  }

  void _setupPlayerListeners() {
    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      // Handle completion
      if (state.processingState == ProcessingState.completed) {
        handleSongCompletion();
      }
    });
  }

  Future<void> playMusic(Music music,
      {PlaylistModel? playlist, Albums? album, int? idx}) async {
    currentMusic.value = music;
    currentPlaylist = playlist;
    currentAlbum = album;
    currentIndex = RxInt(idx ?? 0);
    isPlayerVisible.value = true;

    await _loadAndPlayMusic();
  }

  Future<void> _loadAndPlayMusic() async {
    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();
      if (!isTokenValid) {
        print("Failed to refresh token.");
        return;
      }

      MusicApi musicApi = MusicApi();
      Music musicData;

      if (currentPlaylist != null && currentIndex != null) {
        musicData = await musicApi
            .fetchMusic(currentPlaylist!.musics![currentIndex!.value].trackId);
      } else if (currentAlbum != null && currentIndex != null) {
        musicData = await musicApi
            .fetchMusic(currentAlbum!.musics![currentIndex!.value].trackId);
      } else {
        musicData = await musicApi.fetchMusic(currentMusic.value!.trackId);
      }

      final yt = YoutubeExplode();
      final video = (await yt.search
          .search("${musicData.songName} ${musicData.artistName ?? ""}"))
          .first;
      final videoId = video.id.value;

      currentMusic.value = musicData;
      currentMusic.value?.duration = video.duration;
      checkTrackSaved(currentMusic.value!.trackId);
      currentMusic.refresh();

      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;

      // Menggunakan just_audio untuk memuat dan memutar audio
      await player.setUrl(audioUrl.toString());
      await player.play();
    } catch (e) {
      print("Error loading music: $e");
    }
  }

  void toggleRepeatMode() {
    // Toggle hanya antara off dan one
    if (player.loopMode == LoopMode.off) {
      player.setLoopMode(LoopMode.one);
    } else {
      player.setLoopMode(LoopMode.off);
    }
  }

  void handleSongCompletion() async {
    if (currentPlaylist != null || currentAlbum != null) {
      var maxIndex = currentPlaylist?.musics?.length ??
          currentAlbum?.musics?.length ??
          0;

      switch (player.loopMode) {
        case LoopMode.off:
          if (currentIndex!.value < maxIndex - 1) {
            playNext();
          }
          break;

        case LoopMode.one:
          await player.seek(Duration.zero);
          await player.play();
          break;

        default:
        // Handle any other case as LoopMode.off
          if (currentIndex!.value < maxIndex - 1) {
            playNext();
          }
          break;
      }
    } else {
      // Jika single track
      if (player.loopMode == LoopMode.one) {
        await player.seek(Duration.zero);
        await player.play();
      }
    }
  }

  void playNext() async {
    if (currentIndex != null &&
        (currentPlaylist != null || currentAlbum != null)) {
      var maxIndex =
          currentPlaylist?.musics?.length ?? currentAlbum?.musics?.length ?? 0;

      if (currentIndex!.value < maxIndex - 1) {
        currentIndex!.value++;
        await _loadAndPlayMusic();
      } else if (player.loopMode == LoopMode.all) {
        currentIndex!.value = 0;
        await _loadAndPlayMusic();
      }
    }
  }

  void playPrevious() async {
    if (currentIndex != null &&
        (currentPlaylist != null || currentAlbum != null)) {
      if (currentIndex!.value > 0) {
        currentIndex!.value--;
        await _loadAndPlayMusic();
      } else if (player.loopMode == LoopMode.all) {
        currentIndex!.value =
            (currentPlaylist?.musics?.length ?? currentAlbum?.musics?.length ?? 1) - 1;
        await _loadAndPlayMusic();
      }
    }
  }

  void musicSnackbar(String message) {
    Get.snackbar("Oopss!", message, backgroundColor: Colors.white, colorText: Colors.black);
  }

  void musicSnackbarSuccess(String message) {
    Get.snackbar("Success!", message, backgroundColor: Colors.white, colorText: Colors.black);
  }

  void checkTrackSaved(String trackId){
    for (Music item in userController.userLikedTracks){
      if (item.trackId == trackId){
        isSongLiked.value = true;
      }
    }
  }

  void toggleSave(String trackId) async {
    if (!isSongLiked.value) {
      await saveTrack(trackId);
    } else {
      await deleteTrack(trackId);
    }
  }

  Future<void> saveTrack(String trackId) async {
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if (!isTokenValid) {
      print("Token tidak valid atau gagal diperbarui.");
      return;
    }
    try {
      await MusicApi().saveTrack(trackId);
      musicSnackbarSuccess("Lagu berhasil disimpan");
      isSongLiked.value = true;
      print("apakah lagu disimpan: ${isSongLiked.value}");
      await userController.getUserPlaylist();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTrack(String trackId) async {
    bool isTokenValid = await TokenManager.refreshAccessToken();
    if (!isTokenValid) {
      return;
    }
    try {
      await MusicApi().deleteTrack(trackId);
      musicSnackbarSuccess("Lagu berhasil dihapus dari favorit");
      isSongLiked.value = false;
      print("apakah lagu disimpan: ${isSongLiked.value}");
      await userController.getUserPlaylist();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
