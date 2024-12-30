import 'package:spotify_group7/data/models/album.dart';
import 'package:spotify_group7/design_system/constant/list_item.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlbumApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/albums';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Albums> fetchAlbum(String albumId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$albumId'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Albums album = Albums.fromMap(responseMap);
      if (album.musics == []) {
        print("music album null");
      }
      return album;
    } else {
      throw Exception('Failed to load playlist');
    }
  }

  Future<List<Albums>> fetchAllAlbum() async {
    List<Albums> albumList = [];
    String ids = listIdAlbum.join(',');
    final response = await http.get(
      Uri.parse('$_baseUrl?ids=$ids'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      for (var item in responseMap['albums']){
        Albums album = Albums.fromMap(item);
        if (album.musics == []) {
          print("music album null");
        }
        albumList.add(album);
      }
      return albumList;
    } else {
      throw Exception('Failed to load playlist');
    }
  }
}
