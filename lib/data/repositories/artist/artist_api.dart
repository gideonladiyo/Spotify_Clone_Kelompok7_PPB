import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify_group7/design_system/constant/string.dart';

class ArtistApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/artists/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Artists> fetchArtist(String artistId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$artistId'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Artists artist = Artists.fromMap(responseMap);
      return artist;
    } else {
      throw Exception('Failed to load playlist');
    }
  }

  Future<List<Music>> fetchArtistTracks(String artistId) async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/artists/$artistId/top-tracks'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<Music> loadedMusic = [];
      for (var item in responseMap['tracks']) {
        Music musicData = Music.fromMap(item);
        loadedMusic.add(musicData);
      }
      return loadedMusic;
    } else {
      throw Exception('Failed to load playlist');
    }
  }

  Future<List<Albums>> fetchArtistAlbums(String artistId) async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/artists/$artistId/albums'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<Albums> loadedAlbum = [];
      for (var item in responseMap['items']) {
        Albums albumData = Albums.fromMap(item);
        loadedAlbum.add(albumData);
      }
      return loadedAlbum;
    } else {
      throw Exception('Failed to load playlist');
    }
  }
}
