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
              // Add the PopupMenuButton for trailing options
              if (playlist.authorId == controller.user.value?.userId && playlist.id != 'userLikedTrackPlaylist')
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditPlaylistForm(context);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
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

  void _showEditPlaylistForm(BuildContext context) {
    // Pass the current playlist's data to the CreatePlaylistForm
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreatePlaylistForm(
          userId: controller.user.value?.userId ?? '',
          playlist: playlist, // Pass the current playlist to pre-fill the form
        );
      },
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
          child: Text(
            "Musics Empty",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          ),
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

class CreatePlaylistForm extends StatelessWidget {
  final String userId;
  final PlaylistModel? playlist;

  CreatePlaylistForm({required this.userId, this.playlist});
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
      text: playlist?.title ?? '',
    );
    final TextEditingController descController = TextEditingController(
      text: playlist?.deskripsi ?? '',
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              playlist == null ? 'Create Playlist' : 'Edit Playlist', // Change title based on whether it's a new or existing playlist
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Playlist Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: 'Playlist Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            SizedBox(height: 10),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    await controller.editPlaylist(
                        userId,
                        nameController.text,
                        descController.text,
                        playlist!.id
                    );
                    Navigator.of(context).pop();
                    await controller.getUserPlaylist();
                  },
                  child: Text(
                    playlist == null ? 'Create' : 'Save',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
