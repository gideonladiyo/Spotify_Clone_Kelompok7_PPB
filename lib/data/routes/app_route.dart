import 'package:get/get.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';

class AppRoute {
  static const musicPage = '/music-player';

  static final routes = [
    GetPage(
      name: musicPage,
      page: () => MusicPlayer(),
    ),
  ];
}
