// import 'package:get/get.dart';
// import 'package:spotify_group7/data/models/music.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import '../../data/functions/api.dart';
// import '../../data/functions/token_manager.dart';
//
// class MusicPlayerController extends GetxController{
//   final player = AudioPlayer();
//   Rx<Music> currentMusic = Music(trackId: '').obs;
//   Rx<Duration> currentPosition = Duration.zero.obs;
//   Rx<Duration> totalDuration = Duration(minutes: 4).obs;
//   RxBool isPlaying = false.obs;
//
//   @override
//   void onInit(){
//     super.onInit();
//     listenToPlayer();
//   }
//
//   void listenToPlayer() {
//     player.onDurationChanged.listen((position) {
//       print("Current position $position");
//       currentPosition.value = position;
//     });
//     player.onPlayerStateChanged.listen((state) {
//       isPlaying.value = state == PlayerState.playing;
//     });
//   }
//
//   Future<void> playMusic(Music music) async{
//     try {
//       bool isTokenValid = await TokenManager.refreshAccessToken();
//       if (!isTokenValid) throw Exception("Token refresh failed.");
//
//       MusicApi musicApi = MusicApi();
//       Music updatedMusic = await musicApi.fetchMusic(music.trackId);
//       currentMusic.value = updatedMusic;
//
//       final yt = YoutubeExplode();
//       final video = (await yt.search.search("${music.songName} ${music.artistName ?? ''}")).first;
//       final manifest = await yt.videos.streamsClient.getManifest(video.id.value);
//       final audioUrl = manifest.audioOnly.last.url;
//
//       totalDuration.value = updatedMusic.duration ?? Duration(minutes: 4);
//       await player.play(UrlSource(audioUrl.toString()));
//     } catch (e) {
//       print("Error loading music: $e");
//     }
//   }
//
//   void pauseMusic() => player.pause();
//   void resumeMusic() => player.resume();
//   void seekTo(Duration position) => player.seek(position);
//
//   @override
//   void onClose(){
//     player.dispose();
//     super.onClose();
//   }
// }