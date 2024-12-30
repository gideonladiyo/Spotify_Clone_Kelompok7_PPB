import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/design_system/constant/list_item.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaylistApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/playlists';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  static Future<PlaylistModel> fetchPlaylist(String playlistId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$playlistId'),
      headers: {
        'Authorization': _authToken,
      },
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      if (responseMap['tracks'] is Map<String, dynamic>) {
        int totalTracks = responseMap['tracks']['total'] ?? 0;

        List<Music> musics = [];
        if (totalTracks > 0 &&
            responseMap['tracks']['items'] is List<dynamic>) {
          for (var track in responseMap['tracks']['items']) {
            if (track != null && track['track'] != null) {
              Music musicData = Music.fromMap(track['track']);
              musics.add(musicData);
            }
          }
        }
        PlaylistModel playlist = PlaylistModel.fromMap(responseMap);
        playlist.musics = totalTracks > 0 ? musics : null;
        return playlist;
      } else {
        throw Exception('Invalid tracks data format');
      }
    } else {
      throw Exception('Failed to load playlist');
    }
  }

  static Future<List<String>> fetchIdSongs(String playlistId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$playlistId'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      List<String> listIdSongs = [];

      for (dynamic item in responseMap['tracks']['items']) {
        print("Found id song ${item['track']['id']}");
        listIdSongs.add(item['track']['id']);
      }
      return listIdSongs;
    } else {
      throw Exception('Failed to load playlist');
    }
  }
}
