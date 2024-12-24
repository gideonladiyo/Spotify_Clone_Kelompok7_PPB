import 'package:flutter/widgets.dart';
import 'package:spotify_group7/data/models/artists.dart';
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/repositories/artist/artist_api.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';

class MusicApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/tracks/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Music> fetchMusic(String musicId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$musicId'),
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

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }
}
