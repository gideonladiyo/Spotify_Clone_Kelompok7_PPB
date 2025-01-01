import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/music/music_player_controller.dart';
import 'package:spotify_group7/data/functions/text_controller.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/widgets/art_work_image.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatelessWidget {
  final MusicController controller = Get.put(MusicController());

  // Helper function to determine if background is dark
  bool isDarkColor(Color color) {
    // Calculate relative luminance using standard formula
    double luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance < 0.5;
  }

  // Get appropriate text color based on background
  Color getTextColor(Color backgroundColor) {
    return isDarkColor(backgroundColor) ? Colors.white : Colors.black;
  }

  Color getSecondaryTextColor(Color backgroundColor) {
    return isDarkColor(backgroundColor)
        ? Colors.white.withOpacity(0.6)
        : Colors.black.withOpacity(0.6);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      final backgroundColor = controller.currentMusic.value?.songColor ?? Colors.transparent;
      final primaryTextColor = getTextColor(backgroundColor);
      final secondaryTextColor = getSecondaryTextColor(backgroundColor);

      return Scaffold(
        backgroundColor: backgroundColor,
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
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: primaryTextColor,
                              backgroundImage: controller.currentMusic.value?.artistImage != null
                                  ? NetworkImage(controller.currentMusic.value!.artistImage!)
                                  : null,
                              radius: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              controller.currentMusic.value?.artistName ?? '-',
                              style: textTheme.bodyLarge?.copyWith(
                                color: primaryTextColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: ArtWorkImage(
                      image: controller.currentMusic.value?.songImage,
                    ),
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
                                  controller.currentMusic.value?.songName ?? '',
                                  24,
                                ),
                                style: textTheme.titleLarge?.copyWith(
                                  color: primaryTextColor,
                                ),
                              ),
                              Text(
                                controller.currentMusic.value?.artistName ?? '-',
                                style: textTheme.titleMedium?.copyWith(
                                  color: secondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              controller.toggleSave(controller.currentMusic.value!.trackId);
                            },
                            icon: Obx(() {
                              return Icon(
                                Icons.favorite,
                                color: controller.isSongLiked.value
                                    ? AppColors.primaryColor
                                    : primaryTextColor,
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      StreamBuilder<Duration>(
                        stream: controller.player.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration = controller.player.duration ?? Duration.zero;

                          return ProgressBar(
                            progress: position,
                            total: duration,
                            bufferedBarColor: primaryTextColor.withOpacity(0.38),
                            baseBarColor: primaryTextColor.withOpacity(0.1),
                            thumbColor: primaryTextColor,
                            timeLabelTextStyle: TextStyle(color: primaryTextColor),
                            progressBarColor: primaryTextColor,
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
                          Opacity(
                            opacity: 0.0,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.lyrics_outlined,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
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
                            icon: Icon(
                              Icons.skip_previous,
                              color: primaryTextColor,
                              size: 36,
                            ),
                          ),
                          StreamBuilder<PlayerState>(
                            stream: controller.player.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final processingState = playerState?.processingState;
                              final playing = playerState?.playing;

                              if (processingState == ProcessingState.loading ||
                                  processingState == ProcessingState.buffering) {
                                return Container(
                                  margin: EdgeInsets.all(8.0),
                                  width: 60.0,
                                  height: 60.0,
                                  child: CircularProgressIndicator(
                                    color: primaryTextColor,
                                  ),
                                );
                              } else if (playing != true) {
                                return IconButton(
                                  icon: Icon(Icons.play_circle, size: 60),
                                  color: primaryTextColor,
                                  onPressed: controller.player.play,
                                );
                              } else if (processingState != ProcessingState.completed) {
                                return IconButton(
                                  icon: Icon(Icons.pause, size: 60),
                                  color: primaryTextColor,
                                  onPressed: controller.player.pause,
                                );
                              } else {
                                return IconButton(
                                  icon: Icon(Icons.replay, size: 60),
                                  color: primaryTextColor,
                                  onPressed: () => controller.player.seek(Duration.zero),
                                );
                              }
                            },
                          ),
                          IconButton(
                            onPressed: () async {
                              if (controller.currentIndex != null &&
                                  (controller.currentPlaylist != null ||
                                      controller.currentAlbum != null)) {
                                await controller.player.pause();
                                controller.playNext();
                              } else {
                                controller.musicSnackbar(
                                    "Tidak bisa memutar musik selanjutnya"
                                );
                              }
                            },
                            icon: Icon(
                              Icons.skip_next,
                              color: primaryTextColor,
                              size: 36,
                            ),
                          ),
                          IconButton(
                            onPressed: controller.toggleRepeatMode,
                            icon: StreamBuilder<LoopMode>(
                              stream: controller.player.loopModeStream,
                              builder: (context, snapshot) {
                                final loopMode = snapshot.data ?? LoopMode.off;

                                return Icon(
                                  loopMode == LoopMode.one ? Icons.repeat_one : Icons.repeat,
                                  color: loopMode == LoopMode.one
                                      ? AppColors.primaryColor
                                      : primaryTextColor,
                                );
                              },
                            ),
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