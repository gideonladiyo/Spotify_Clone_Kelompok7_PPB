import 'package:flutter/material.dart';
import 'package:spotify_group7/data/functions/api.dart';
import 'package:spotify_group7/data/functions/token_manager.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
import 'package:spotify_group7/presentation/music_player/music_player.dart';
import '../../data/models/music.dart';
import '../../data/models/playlist.dart';


class PlaylistDetail extends StatefulWidget {
  final PlaylistModel playlist;

  const PlaylistDetail({Key? key, required this.playlist}) : super(key: key);

  @override
  State<PlaylistDetail> createState() => _PlaylistDetailState();
}

class _PlaylistDetailState extends State<PlaylistDetail> {
  List<Music> musicList = [];
  List<String> listMusicId = [];

  @override
  void initState() {
    super.initState();
    _loadIdSongs();
  }
  _loadIdSongs() async {
    try {
      bool isTokenValid = await TokenManager.refreshAccessToken();

      if (!isTokenValid) {
        print("Failed to refresh token");
        return;
      }
      List<String> songData =
          await PlaylistApi.fetchIdSongs(widget.playlist.id);

      setState(() {
        listMusicId = songData; // Memperbarui list musicId
      });
      _loadSongs();
    } catch (e) {
      print("Error loading playlist ${widget.playlist.id}: $e");
    }
  }
  _loadSongs() async {
    List<Music> loadedMusic = [];
    MusicApi musicApi = MusicApi();
    for (String musicId in listMusicId) {
      try {
        bool isTokenValid = await TokenManager.refreshAccessToken();

        if (!isTokenValid) {
          print("Failed to refresh token.");
          return;
        }
        Music music = await musicApi.fetchMusic(musicId);
        loadedMusic.add(music);
      } catch (e) {
        print("Error loading music $musicId: $e");
      }
    }
    setState(() {
      musicList = loadedMusic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlist.title ?? "No title"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.playlist.imageUrl ?? "default_image_url"),
            const SizedBox(height: 16.0),
            Text(
              widget.playlist.title ?? "No title",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.playlist.count ?? "0 Song",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            // Menambahkan ListView.builder
            musicList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: musicList.length,
                      itemBuilder: (context, index) {
                        Music music = musicList[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext builder) => MusicPlayer(music: music)
                            ));
                          },
                          child: MusicTile(
                              songPlayerDirections: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => MusicPlayer(music: music),
                                  ),
                                );
                              },
                              deleteTap: () {},
                              music: music)
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}