import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/users.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApi {
  static const String url = 'https://api.spotify.com/v1/me';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Users> getUserInfo() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': _authToken,
      },
    );
    print("url: $url");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Users user = Users.fromMap(responseMap);
      print("User ID:${user.userId}");
      return user;
    } else {
      print('failed load user');
      throw Exception('Failed to load user info');
    }
  }

  Future<List<Music>> getUserSavedTracks() async {
    final url = 'https://api.spotify.com/v1/me/tracks';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': _authToken,
      },
    );
    print("Fetching saved tracks from URL: $url");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<dynamic> items = responseMap['items'];

      List<Future<Music?>> fetchTasks = items.map((item) async {
        try {
          if (item['track'] != null) {
            return Music.fromMap(item['track']);
          } else {
            throw Exception('Track data is null');
          }
        } catch (e) {
          print('Error fetching track: $e');
          return null;
        }
      }).toList();

      List<Music?> results = await Future.wait(fetchTasks);

      return results.whereType<Music>().toList();
    } else {
      print('Failed to load user saved tracks');
      throw Exception('Failed to load user saved tracks');
    }
  }

  Future<List<String>> getUserPlaylist() async {
    List<String> loadedPlaylist = [];
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me/playlists'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<dynamic> items = responseMap['items'];

      for (var item in items) {
        print(item['id']);
        loadedPlaylist.add(item['id']);
      }

      return loadedPlaylist;
    } else {
      print('Failed to load playlists');
      throw Exception('Failed to load user playlists');
    }
  }

  Future<void> createPlaylist(String userId, String playlistName,
      String playlistDescription, bool isPublic) async {
    final String endPoint =
        'https://api.spotify.com/v1/users/$userId/playlists';
    final Map<String, dynamic> body = {
      'name': playlistName,
      'description': playlistDescription,
      'public': isPublic
    };

    try {
      if (_authToken.isEmpty) {
        throw Exception('Auth token is null or empty');
      }
      final response = await http.post(Uri.parse(endPoint),
          headers: {
            'Authorization': _authToken,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));

      if (response.statusCode == 201) {
        print("Playlist berhasil dibuat");
      } else {
        print("playlist gagal dibuat");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Music>> getTopTracks() async {
    String url =
        'https://api.spotify.com/v1/me/top/tracks?time_range=short_term&limit=5';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': _authToken,
      },
    );
    print("url: $url");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<Music> tracks = [];
      for (var item in responseMap['items']) {
        if (item == null) {
          continue;
        }
        Music music = Music.fromMap(item);
        tracks.add(music);
      }
      return tracks;
    } else {
      print('failed load music');
      throw Exception('Failed to search tracks');
    }
  }

  Future<List<Artists>> getTopArtists() async {
    String url =
        'https://api.spotify.com/v1/me/top/artists?time_range=short_term&limit=5';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': _authToken,
      },
    );
    print("url: $url");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<Artists> artists = [];
      for (var item in responseMap['items']) {
        if (item == null) {
          continue;
        }
        Artists artist = Artists.fromMap(item);
        artists.add(artist);
      }
      return artists;
    } else {
      print('failed load music');
      throw Exception('Failed to search tracks');
    }
  }

  Future<void> savePlaylist(String playlistId) async {
    String endPoint = 'https://api.spotify.com/v1/playlists/$playlistId/followers';

    try {
      if (_authToken.isEmpty) {
        throw Exception('Auth token is null or empty');
      }

      final response = await http.put(
        Uri.parse(endPoint),
        headers: {
          'Authorization': _authToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Playlist berhasil disimpan");
      } else {
        print(
            "Playlist gagal disimpan: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deletePlaylist(String playlistId) async {
    String endPoint = 'https://api.spotify.com/v1/playlists/$playlistId/followers';

    try {
      if (_authToken.isEmpty) {
        throw Exception('Auth token is null or empty');
      }

      final response = await http.delete(
        Uri.parse(endPoint),
        headers: {
          'Authorization': _authToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Playlist berhasil dihapus");
      } else {
        print("Playlist gagal dihapus: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
