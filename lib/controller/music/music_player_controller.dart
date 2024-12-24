import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../data/functions/token_manager.dart';
import '../../data/models/music.dart';
import '../../data/models/playlist.dart';
import 'package:get/get.dart';

class MusicPlayerController extends GetxController {
  AudioPlayer player = AudioPlayer();
  var idx = 0.obs;
  var playlist = Rx<PlaylistModel?>(null);
  var music = Rx<Music?>(null);

  void setVar(PlaylistModel? playlistInput, Music musicInput, int currentIdx){
    playlist.value = playlistInput;
    music.value = musicInput;
    idx.value = currentIdx;
  }

  void prevNextMusic(int newIndex) {
    idx.value = newIndex;
    music.value = playlist.value!.musics?[idx.value];
    player.play(UrlSource(music.value!.audioUrl!));
    loadPlayer(music.value!);
  }

  void snackBar() {
    Get.snackbar("Oops!", "Can't skip/back to track!");
  }

  void pauseMusic() {
    player.pause();
  }

  void resumeMusic() {
    player.resume();
  }

  void onInit() {
    super.onInit();
  }

  void loadPlayer(Music music) async{
    final yt = YoutubeExplode();
    final video =
        (await yt.search.search("${music.songName} ${music.artistName ?? ""}"))
            .first;
    final videoId = video.id.value;
    music.duration = video.duration;
    var manifest = await yt.videos.streamsClient.getManifest(videoId);
    music.audioUrl = (manifest.audioOnly.last.url.toString());
    player.play(UrlSource(music.audioUrl ?? ""));
  }
}