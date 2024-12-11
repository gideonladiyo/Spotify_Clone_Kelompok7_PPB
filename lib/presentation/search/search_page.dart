import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/controller/search/search_controller.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final SearchPageController controller = Get.put(SearchPageController());

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText:
                          'Search for songs, playlists, artists, or albums...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      controller.performSearch(searchController.text);
                    }
                  },
                  child: Icon(Icons.search, color: Colors.black,),
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.musicResult.isEmpty) {
                  return Center(child: Text('No results found.'));
                }

                return ListView.builder(
                  itemCount: controller.musicResult.length,
                  itemBuilder: (context, index) {
                    final result = controller.musicResult[index];
                    return MusicTile(
                        songPlayerDirections: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext builder) =>
                                      MusicPlayer(music: result)));
                        },
                        music: result);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
