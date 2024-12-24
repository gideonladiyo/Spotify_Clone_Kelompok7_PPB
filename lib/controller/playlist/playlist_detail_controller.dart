// import 'package:get/get.dart';
// import 'package:spotify_group7/data/models/music.dart';
//
// import '../../data/functions/api.dart';
// import '../../data/functions/token_manager.dart';
//
// class PlaylistDetailController extends GetxController{
//   var listMusicId = <String>[].obs;
//   var musicList = <Music>[].obs;
//
//   void loadIdSongs(String playlistId) async{
//     try {
//       bool isTokenValid = await TokenManager.refreshAccessToken();
//
//       if (!isTokenValid) {
//         print("Failed to refresh token");
//         return;
//       }
//       List<String> songData =
//       await PlaylistApi.fetchIdSongs(playlistId);
//       listMusicId.value = songData;
//
//       List<Music> loadedMusic = [];
//       MusicApi musicApi = MusicApi();
//
//       for (String musicId in listMusicId) {
//         try {
//           bool isTokenValid = await TokenManager.refreshAccessToken();
//
//           if (!isTokenValid) {
//             print("Failed to refresh token.");
//             return;
//           }
//           Music music = await musicApi.fetchMusic(musicId);
//           loadedMusic.add(music);
//         } catch (e) {
//           print("Error loading music $musicId: $e");
//         }
//       }
//       musicList.value = loadedMusic;
//     } catch (e) {
//       print("Error loading playlist ${playlistId}: $e");
//     }
//   }
// }