import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotify_group7/data/functions/text_controller.dart';
import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/data/repositories/music/music_api.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/widgets/art_work_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../data/functions/token_manager.dart';

// ignore: must_be_immutable
class MusicPlayer extends StatefulWidget {
  final Music music;
  PlaylistModel? playlist;
  int? idx;
  Albums? album;
  MusicPlayer(
      {super.key, required this.music, this.playlist, this.idx, this.album});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(
        "MusicPlayer initialized with: music=${widget.music.trackId}, playlist=${widget.playlist?.id}, album=${widget.album?.id}, idx=${widget.idx}");
    _loadMusic();
  }

  _loadMusic() async {
    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();
      if (!isTokenValid) {
        print("Failed to refresh token.");
        return;
      }

      MusicApi musicApi = MusicApi();
      Music musicData;

      if (widget.playlist != null && widget.idx != null) {
        musicData = await musicApi
            .fetchMusic(widget.playlist!.musics![widget.idx!].trackId);
      } else if (widget.album != null && widget.idx != null) {
        musicData = await musicApi
            .fetchMusic(widget.album!.musics![widget.idx!].trackId);
      } else {
        musicData = await musicApi.fetchMusic(widget.music.trackId);
      }

      Music music = musicData;
      final yt = YoutubeExplode();
      final video = (await yt.search
              .search("${music.songName} ${music.artistName ?? ""}"))
          .first;
      final videoId = video.id.value;
      music.duration = video.duration;
      widget.music.duration = video.duration;
      setState(() {
        widget.music.artistName = music.artistName;
        widget.music.songName = music.songName;
        widget.music.songImage = music.songImage;
        widget.music.artistImage = music.artistImage;
        widget.music.songColor = music.songColor;
        widget.music.duration = music.duration;
      });
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;
      player.play(UrlSource(audioUrl.toString()));
    } catch (e) {
      print("Error loading music: $e");
    }
  }

  void _prevNextMusic(int newIndex) {
    if (widget.playlist != null) {
      setState(() {
        widget.idx = newIndex;
        _loadMusic();
      });
    } else if (widget.album != null) {
      setState(() {
        widget.idx = newIndex;
        _loadMusic();
      });
    } else {
      _showSnackbar();
    }
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tidak bisa next/prev. Sumber data tidak valid."),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: widget.music.songColor,
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
                            backgroundImage: widget.music.artistImage != null
                                ? NetworkImage(widget.music.artistImage!)
                                : null,
                            radius: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.music.artistName ?? '-',
                            style: textTheme.bodyLarge
                                ?.copyWith(color: Colors.white),
                          )
                        ],
                      )
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
                    child: ArtWorkImage(image: widget.music.songImage),
                  )),
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
                            truncateTitle(widget.music.songName ?? '', 24),
                            style: textTheme.titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            widget.music.artistName ?? '-',
                            style: textTheme.titleMedium
                                ?.copyWith(color: Colors.white60),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.favorite,
                        color: AppColors.primaryColor,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder<Duration>(
                    stream: player.onPositionChanged,
                    builder: (context, data) {
                      final currentDuration = data.data ?? Duration.zero;
                      final totalDuration = widget.music.duration ?? const Duration(minutes: 4);

                      if (currentDuration >= totalDuration) {
                        _prevNextMusic(widget.idx! + 1);
                      }

                      return ProgressBar(
                        progress: currentDuration,
                        total: totalDuration,
                        bufferedBarColor: Colors.white38,
                        baseBarColor: Colors.white10,
                        thumbColor: Colors.white,
                        timeLabelTextStyle: const TextStyle(color: Colors.white),
                        progressBarColor: Colors.white,
                        onSeek: (duration) {
                          player.seek(duration);
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
                            if (widget.idx != null &&
                                (widget.playlist != null ||
                                    widget.album != null)) {
                              await player.pause();
                              _prevNextMusic(widget.idx! - 1);
                            } else {
                              _showSnackbar();
                            }
                          },
                          icon: const Icon(Icons.skip_previous,
                              color: Colors.white, size: 36)),
                      IconButton(
                          onPressed: () async {
                            if (player.state == PlayerState.playing) {
                              await player.pause();
                            } else {
                              await player.resume();
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            player.state == PlayerState.playing
                                ? Icons.pause
                                : Icons.play_circle,
                            color: Colors.white,
                            size: 60,
                          )),
                      IconButton(
                          onPressed: () async {
                            if (widget.idx != null &&
                                (widget.playlist != null ||
                                    widget.album != null)) {
                              await player.pause();
                              _prevNextMusic(widget.idx! + 1);
                            } else {
                              _showSnackbar();
                            }
                          },
                          icon: const Icon(Icons.skip_next,
                              color: Colors.white, size: 36)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.loop,
                              color: AppColors.primaryColor)),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
