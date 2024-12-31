import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/music/music_player_controller.dart';
import 'package:spotify_group7/data/functions/text_controller.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/widgets/art_work_image.dart';
import 'package:get/get.dart';

class MusicPlayer extends StatelessWidget {
  final MusicController controller = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      return Scaffold(
        backgroundColor:
            controller.currentMusic.value?.songColor ?? Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.close, color: Colors.transparent),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Singing Now',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColors.primaryColor),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  controller.currentMusic.value?.artistImage !=
                                          null
                                      ? NetworkImage(controller
                                          .currentMusic.value!.artistImage!)
                                      : null,
                              radius: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              controller.currentMusic.value?.artistName ?? '-',
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: ArtWorkImage(
                        image: controller.currentMusic.value?.songImage),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                truncateTitle(
                                    controller.currentMusic.value?.songName ??
                                        '',
                                    24),
                                style: textTheme.titleLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                controller.currentMusic.value?.artistName ??
                                    '-',
                                style: textTheme.titleMedium
                                    ?.copyWith(color: Colors.white60),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: (){
                              controller.toggleSave(controller.currentMusic.value!.trackId);
                            },
                            icon: Obx(() {
                              return Icon(
                                Icons.favorite,
                                color: controller.isSongLiked.value
                                    ? AppColors.primaryColor
                                    : Colors.white,
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      StreamBuilder<Duration>(
                        stream: controller.player.onPositionChanged,
                        builder: (context, data) {
                          final currentDuration = data.data ?? Duration.zero;
                          final totalDuration =
                              controller.currentMusic.value?.duration ??
                                  const Duration(minutes: 4);
                          print(
                              "Durasi dalam stream builder: ${controller.currentMusic.value?.duration}");

                          if (currentDuration >= totalDuration) {
                            controller.playNext();
                          }

                          return ProgressBar(
                            progress: currentDuration,
                            total: totalDuration,
                            bufferedBarColor: Colors.white38,
                            baseBarColor: Colors.white10,
                            thumbColor: Colors.white,
                            timeLabelTextStyle:
                                const TextStyle(color: Colors.white),
                            progressBarColor: Colors.white,
                            onSeek: (duration) {
                              controller.player.seek(duration);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.lyrics_outlined,
                                  color: Colors.white)),
                          IconButton(
                              onPressed: () async {
                                if (controller.currentIndex != null &&
                                    (controller.currentPlaylist != null ||
                                        controller.currentAlbum != null)) {
                                  await controller.player.pause();
                                  controller.playPrevious();
                                } else {
                                  controller.musicSnackbar(
                                      "Tidak bisa memutar musik sebelumnya");
                                }
                              },
                              icon: const Icon(Icons.skip_previous,
                                  color: Colors.white, size: 36)),
                          Obx(() {
                            return IconButton(
                              onPressed: () async {
                                if (controller.isPlaying.value) {
                                  await controller.player.pause();
                                } else {
                                  await controller.player.resume();
                                }
                              },
                              icon: Icon(
                                controller.isPlaying.value
                                    ? Icons.pause
                                    : Icons.play_circle,
                                color: Colors.white,
                                size: 60,
                              ),
                            );
                          }),
                          IconButton(
                              onPressed: () async {
                                if (controller.currentIndex != null &&
                                    (controller.currentPlaylist != null ||
                                        controller.currentAlbum != null)) {
                                  await controller.player.pause();
                                  controller.playNext();
                                } else {
                                  controller.musicSnackbar(
                                      "Tidak bisa memutar musik selanjutnya idx(${controller.currentIndex})");
                                }
                              },
                              icon: const Icon(Icons.skip_next,
                                  color: Colors.white, size: 36)),
                          IconButton(
                            onPressed: controller.toggleRepeatMode,
                            icon: Obx(() {
                              IconData iconData;
                              Color iconColor;
                              switch (controller.repeatMode.value) {
                                case RepeatMode.off:
                                  iconData = Icons.repeat;
                                  iconColor = Colors.white;
                                  break;
                                case RepeatMode.single:
                                  iconData = Icons.repeat_one;
                                  iconColor = AppColors.primaryColor;
                                  break;
                                case RepeatMode.playlist:
                                  iconData = Icons.repeat;
                                  iconColor = AppColors.primaryColor;
                                  break;
                              }
                              return Icon(iconData, color: iconColor);
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
