import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/data/repositories/playlist/playlist_api.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/search';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<List<Music>> searchTracks(String query) async {
    String encodedQuery = Uri.encodeComponent(query);
    String url = '$_baseUrl?q=$encodedQuery&type=track&limit=10';

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
      for (var item in responseMap['tracks']['items']) {
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

  Future<List<PlaylistModel>> searchPlaylist(String query) async {
    String encodedQuery = Uri.encodeComponent(query);
    String url = '$_baseUrl?q=$encodedQuery&type=playlist&limit=10';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': _authToken,
      },
    );
    print("url: $url");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<PlaylistModel> playlists = [];

      for (var item in responseMap['playlists']['items']) {
        if (item == null) {
          continue;
        }
        try {
          PlaylistModel playlistData =
              await PlaylistApi.fetchPlaylist(item['id']);
          playlists.add(playlistData);
        } catch (e) {
          print("Skipped playlist with ID ${item['id']} due to error: $e");
          continue;
        }
      }

      return playlists;
    } else {
      print('failed load playlist');
      throw Exception('Failed to search playlist');
    }
  }

  Future<List<Artists>> searchArtist(String query) async {
    String encodedQuery = Uri.encodeComponent(query);
    String url = '$_baseUrl?q=$encodedQuery&type=artist&limit=10';

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
      for (var item in responseMap['artists']['items']) {
        if (item == null) {
          continue;
        }
        Artists artistData = Artists.fromMap(item);
        artists.add(artistData);
      }
      return artists;
    } else {
      print('failed load playlist');
      throw Exception('Failed to search artist');
    }
  }

  Future<List<Albums>> searchAlbum(String query) async {
    String encodedQuery = Uri.encodeComponent(query);
    String url = '$_baseUrl?q=$encodedQuery&type=album&limit=10';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': _authToken,
      },
    );
    print("url: $url");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<Albums> albums = [];
      for (var item in responseMap['albums']['items']) {
        if (item == null) {
          continue;
        }
        Albums albumData = Albums.fromMap(item);
        albums.add(albumData);
      }
      return albums;
    } else {
      print('failed load playlist');
      throw Exception('Failed to search album');
    }
  }
}
