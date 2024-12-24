import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spotify_group7/controller/search/search_controller.dart';
import 'package:spotify_group7/data/functions/text_controller.dart';
import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/widgets/song_card/artis_horizontal.dart';
import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
import 'package:spotify_group7/design_system/widgets/song_card/playlist_item.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';
import 'package:spotify_group7/presentation/playlist/playlist_view.dart';

import '../artis/artist.dart';

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
                      controller.selectedCategory.value = 'Music';
                      controller.searchTracks(searchController.text);
                    }
                  },
                  child: Icon(Icons.search, color: Colors.black,),
                )
              ],
            ),
            SizedBox(height: 10,),
            Obx(() {
              return Wrap(
                spacing: 10,
                children: [
                  ChoiceChip(
                    label: Text("Music"),
                    selected: controller.selectedCategory.value == 'Music',
                    selectedColor: AppColors.primaryColor,
                    onSelected: (selected) {
                      if (selected) {
                        controller.selectedCategory.value = 'Music';
                        controller.searchTracks(searchController.text);
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text("Playlist"),
                    selected: controller.selectedCategory.value == 'Playlist',
                    selectedColor: AppColors.primaryColor,
                    onSelected: (selected) {
                      if (selected) {
                        controller.selectedCategory.value = 'Playlist';
                        controller.searchPlaylist(searchController.text);
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text("Artist"),
                    selected: controller.selectedCategory.value == 'Artist',
                    selectedColor: AppColors.primaryColor,
                    onSelected: (selected) {
                      if (selected) {
                        controller.selectedCategory.value = 'Artist';
                        controller.searchArtist(searchController.text);
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text("Album"),
                    selected: controller.selectedCategory.value == 'Album',
                    selectedColor: AppColors.primaryColor,
                    onSelected: (selected) {
                      if (selected) {
                        controller.selectedCategory.value = 'Album';
                        controller.searchAlbum(searchController.text);
                      }
                    },
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
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
                final selectedCategory = controller.selectedCategory.value;
                if (selectedCategory == 'Music') {
                  // ListView for Music
                  return ListView.builder(
                    itemCount: controller.musicResult.length,
                    itemBuilder: (context, index) {
                      Music music = controller.musicResult[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext builder) {
                                return MusicPlayer(
                                  music: music,
                                );
                              },
                            ),
                          );
                        },
                        child: MusicTile(
                            songPlayerDirections: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext builder) {
                                      return MusicPlayer(
                                          music: music,
                                      );
                                    }
                                ),
                              );
                            },
                            music: music
                        ), // Add appropriate widget here
                      );
                    },
                  );
                } else if (selectedCategory == 'Artist') {
                  // ListView for Artist
                  return ListView.builder(
                    itemCount: controller.artistResult.length,
                    itemBuilder: (context, index) {
                      Artists artist = controller.artistResult[index];
                      return ArtistTile(
                        artistViewDirections: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext builder) {
                                  print("Navigating to Artist page with: id=${artist.id}");
                                  return ArtistView(artist: artist);
                                }
                            ),
                          );
                        },
                          artist: artist
                      );
                    },
                  );
                } else if (selectedCategory == 'Playlist') {
                  // GridView for Playlist
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: controller.playlistResult.length,
                    itemBuilder: (context, index) {
                      final playlist = controller.playlistResult[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext builder) {
                                return PlaylistDetail(
                                  playlist: playlist,
                                );
                              },
                            ),
                          );
                        },
                        child: PlaylistItem(
                            title: truncateTitle(playlist.title ?? '', 24),
                            count: playlist.count ?? '0 Songs',
                            imageUrl: playlist.imageUrl ?? ''
                        ),
                      );
                    },
                  );
                } else if (selectedCategory == 'Album') {
                  // GridView for Album
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: controller.albumResult.length,
                    itemBuilder: (context, index) {
                      Albums album = controller.albumResult[index];
                      return CustomSongCard(
                        onPressed: () {},
                        imagePath: album.imageUrl,
                        title1: truncateTitle(album.title, 24),
                        title2: album.totalTracks,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Invalid Category"),
                  );
                }
              }),
            ),

          ],
        ),
      ),
    );
  }
}
