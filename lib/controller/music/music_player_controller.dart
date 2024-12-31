import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/controller/profile/user_controller.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/repositories/music/music_api.dart';
import 'package:spotify_group7/data/functions/token_manager.dart';

enum RepeatMode {
  off,
  single,
  playlist
}

class MusicController extends GetxController {
  final player = AudioPlayer();
  final Rx<Music?> currentMusic = Rx<Music?>(null);
  final RxBool isPlaying = false.obs;
  final Rx<RepeatMode> repeatMode = RepeatMode.off.obs;
  final Rx<Duration> currentDuration = Duration.zero.obs;
  final Rx<Duration> totalDuration = const Duration(minutes: 4).obs;
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

  void navigateToMusicPlayer({
    required Music music,
    PlaylistModel? playlist,
    Albums? album,
    int? idx,
  }) {
    playMusic(music, playlist: playlist, album: album, idx: idx);
    Get.toNamed('/music-player');
  }

  void _setupPlayerListeners() {
    player.onPositionChanged.listen((position) {
      currentDuration.value = position;
      if (position >= totalDuration.value) {
        handleSongCompletion();
      }
    });

    player.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
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

  void toggleRepeatMode() {
    switch (repeatMode.value) {
      case RepeatMode.off:
        repeatMode.value = RepeatMode.single;
        break;
      case RepeatMode.single:
        repeatMode.value = RepeatMode.playlist;
        break;
      case RepeatMode.playlist:
        repeatMode.value = RepeatMode.off;
        break;
    }
  }

  void handleSongCompletion() async {
    switch (repeatMode.value) {
      case RepeatMode.single:
        // Putar ulang lagu yang sama
        await player.seek(Duration.zero);
        await player.resume();
        break;

      case RepeatMode.playlist:
        if (currentPlaylist != null || currentAlbum != null) {
          playNext();
        } else {
          // Jika single track, perlakukan seperti repeat single
          await player.seek(Duration.zero);
          await player.resume();
        }
        break;

      case RepeatMode.off:
        if (currentPlaylist != null || currentAlbum != null) {
          var maxIndex = currentPlaylist?.musics?.length ??
              currentAlbum?.musics?.length ??
              0;
          if (currentIndex!.value < maxIndex - 1) {
            playNext();
          } else {
            // Berhenti di akhir playlist
            await player.pause();
            isPlaying.value = false;
          }
        } else {
          // Single track berhenti di akhir
          await player.pause();
          isPlaying.value = false;
        }
        break;
    }
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
      totalDuration.value = video.duration ?? const Duration(minutes: 4);

      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;
      await player.play(UrlSource(audioUrl.toString()));
    } catch (e) {
      print("Error loading music: $e");
    }
  }

  void togglePlay() async {
    if (isPlaying.value) {
      await player.pause();
    } else {
      await player.resume();
    }
  }

  void seekTo(Duration position) {
    player.seek(position);
  }

  void playNext() async {
    if (currentIndex != null &&
        (currentPlaylist != null || currentAlbum != null)) {
      await player.pause();
      var maxIndex =
          currentPlaylist?.musics?.length ?? currentAlbum?.musics?.length ?? 0;

      if (currentIndex!.value < maxIndex - 1) {
        currentIndex!.value++;
        await _loadAndPlayMusic();
      } else if (repeatMode.value == RepeatMode.playlist) {
        currentIndex!.value = 0;
        await _loadAndPlayMusic();
      }
    }
  }

  void playPrevious() async {
    if (currentIndex != null &&
        (currentPlaylist != null || currentAlbum != null)) {
      await player.pause();
      if (currentIndex!.value > 0) {
        currentIndex!.value--;
        await _loadAndPlayMusic();
      } else if (repeatMode.value == RepeatMode.playlist) {
        currentIndex!.value = (currentPlaylist?.musics?.length ??
                currentAlbum?.musics?.length ??
                1) -
            1;
        await _loadAndPlayMusic();
      }
    }
  }

  void musicSnackbar(String message) {
    Get.snackbar("Error!", message);
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
