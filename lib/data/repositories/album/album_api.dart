import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlbumApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/albums/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Albums> fetchAlbum(String albumId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$albumId'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Albums album = Albums.fromMap(responseMap);
      print("ID album: ${album.id}");
      print("Nama album: ${album.title}");
      print("Artist album: ${album.artist}");
      print("Image album: ${album.imageUrl}");
      print("Total album: ${album.totalTracks}");
      if (album.musics == []) {
        print("music album null");
      }
      return album;
    } else {
      throw Exception('Failed to load playlist');
    }
  }
}
