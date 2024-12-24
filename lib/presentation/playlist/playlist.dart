import 'package:flutter/material.dart';
import 'package:spotify_group7/controller/playlist/playlist_controller.dart';
import 'package:spotify_group7/controller/profile/user_controller.dart';
import 'package:spotify_group7/presentation/playlist/playlist_view.dart';
import '../../data/functions/text_controller.dart';
import '../../design_system/widgets/song_card/playlist_item.dart';
import 'package:get/get.dart';

class Playlist extends StatelessWidget {
  Playlist({Key? key}) : super(key: key);
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlist"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CreatePlaylistForm(userId: controller.user.value!.userId)
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return controller.userPlaylist.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: controller.userPlaylist.length,
                  itemBuilder: (context, index) {
                    final playlist = controller.userPlaylist[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext builder) =>
                                PlaylistDetail(playlist: playlist),
                          ),
                        );
                      },
                      child: PlaylistItem(
                        title: truncateTitle(playlist.title ?? "No title", 24),
                        count: playlist.count ?? "0 Songs",
                        imageUrl: playlist.imageUrl ?? "default_image_url",
                      ),
                    );
                  },
                );
        }),
      ),

    );
  }
}

class CreatePlaylistForm extends StatelessWidget {
  final String userId;

  CreatePlaylistForm({required this.userId});
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    bool isPublic = false;

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
              'Create Playlist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Playlist Name'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Playlist Description'),
            ),
            Row(
              children: [
                Text('Public'),
                StatefulBuilder(
                  builder: (context, setState) {
                    return Switch(
                      value: isPublic,
                      onChanged: (value) {
                        setState(() {
                          isPublic = value;
                        });
                      },
                    );
                  },
                )
              ],
            ),
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
                TextButton(
                  onPressed: () async {
                    await controller.createPlaylist(
                      userId,
                      nameController.text,
                      descController.text,
                      isPublic,
                    );
                    Navigator.of(context).pop(); // Tutup dialog
                    await controller
                        .getUserPlaylist(); // Refresh daftar playlist
                  },
                  child: Text('Create'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
