import 'package:flutter/widgets.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/repositories/artist/artist_api.dart';
import 'package:spotify_group7/design_system/constant/list_item.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';

class MusicApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/tracks';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Music> fetchMusic(String musicId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$musicId'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Music music = Music.fromMap(responseMap);
      music.songColor = await getImagePalette(
          NetworkImage(music.songImage ?? "default_image_url"));
      Artists artist = await ArtistApi()
          .fetchArtist(responseMap['album']['artists'][0]['id']);
      music.artistImage = artist.imageUrl;
      return music;
    } else {
      throw Exception('Failed to load music');
    }
  }

  Future<List<Music>> fetchAllMusics() async {
    List<Music> musicList = [];
    String ids = listIdTracks.join(',');
    final response = await http.get(
      Uri.parse('$_baseUrl?ids=$ids'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      for (var item in responseMap['tracks']) {
        Music music = Music.fromMap(item);
        music.songColor = await getImagePalette(NetworkImage(music.songImage ?? "default_image_url"));
        Artists artist = await ArtistApi().fetchArtist(item['album']['artists'][0]['id']);
        music.artistImage = artist.imageUrl;
        musicList.add(music);
      }
      return musicList;
    } else {
      throw Exception('Failed to load music');
    }
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  Future<void> saveTrack(String trackId) async {
    const String endPoint = 'https://api.spotify.com/v1/me/tracks';

    try {
      if (_authToken.isEmpty) {
        throw Exception('Auth token is null or empty');
      }

      final Map<String, dynamic> body = {
        'ids': [trackId]
      };

      final response = await http.put(
        Uri.parse(endPoint),
        headers: {
          'Authorization': '$_authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("Musik berhasil disimpan");
      } else {
        print(
            "Musik gagal disimpan: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteTrack(String trackId) async {
    const String endPoint = 'https://api.spotify.com/v1/me/tracks';

    try {
      if (_authToken.isEmpty) {
        throw Exception('Auth token is null or empty');
      }

      final Map<String, dynamic> body = {
        'ids': [trackId]
      };

      final response = await http.delete(
        Uri.parse(endPoint),
        headers: {
          'Authorization': '$_authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("Musik berhasil dihapus");
      } else {
        print(
            "Musik gagal dihapus: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
