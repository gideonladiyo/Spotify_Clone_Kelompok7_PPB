import 'package:flutter/material.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import '../../data/models/album.dart';

class AlbumView extends StatelessWidget {
  final Albums album;
  const AlbumView({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: _buildAlbumInfo(context),
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
            // Album Image with gradient overlay
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Image.network(
                album.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
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

  Widget _buildAlbumInfo(BuildContext context) {
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
                  "ALBUM",
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
          Text(
            album.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            album.totalTracks,
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

  Widget _buildSongsList() {
    if (album.musics == null || album.musics!.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Music music = album.musics![index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MusicTile(
              music: music,
              index: index,
              album: album,
            ),
          );
        },
        childCount: album.musics!.length,
      ),
    );
  }
}
