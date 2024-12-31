import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/profile/user_controller.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/image_col.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import '../../data/models/music.dart';
import '../../data/models/playlist.dart';
import 'package:get/get.dart';

class PlaylistDetail extends StatelessWidget {
  final PlaylistModel playlist;
  final UserController controller = Get.put(UserController());

  PlaylistDetail({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.checkPlaylistSaved(playlist.id);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: _buildPlaylistInfo(context),
          ),
          _buildSongsList(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.transparent,
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: playlist.imageUrl == ''
                  ? Image.asset(
                      AppImages.logo_lagu,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      playlist.imageUrl ?? "default_image_url",
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildPlaylistInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "PLAYLIST",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  playlist.title ?? "No title",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              if (playlist.authorId != controller.user.value?.userId)
                _buildFavoriteButton(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${playlist.count ?? '0'} songs",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Obx(() {
      return IconButton(
        onPressed: () async {
          controller.toggleSave(playlist.id);
          await controller.getUserPlaylist();
        },
        icon: AnimatedScale(
          scale: controller.isPlaylistSaved.value ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.favorite,
            color: controller.isPlaylistSaved.value
                ? AppColors.primaryColor
                : Colors.white.withOpacity(0.7),
            size: 28,
          ),
        ),
      );
    });
  }

  Widget _buildSongsList() {
    if (playlist.musics == null || playlist.musics!.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Music music = playlist.musics![index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MusicTile(
              music: music,
              index: index,
              playlist: playlist,
            ),
          );
        },
        childCount: playlist.musics!.length,
      ),
    );
  }
}
