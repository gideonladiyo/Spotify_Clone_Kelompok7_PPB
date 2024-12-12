import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/album.dart';
import '../models/artists.dart';

class PlaylistApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/playlists/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  static Future<PlaylistModel> fetchPlaylist(String playlistId) async {
    print(playlistId);
    final response = await http.get(
      Uri.parse('$_baseUrl$playlistId'),
      headers: {
        'Authorization': _authToken,
      },
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      int? totalTracks = responseMap['tracks']?['total'];
      if (totalTracks != null){
        print("Total tracks: $totalTracks");
      } else {
        print("Tidak ditemukan total");
      }
      PlaylistModel playlist = PlaylistModel.fromMap(responseMap);

      return playlist;
    } else {
      throw Exception('Failed to load playlist');
    }
  }

  static Future<List<String>> fetchIdSongs(String playlistId) async{
    final response = await http.get(
      Uri.parse('$_baseUrl$playlistId'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      
      List<String> listIdSongs = [];

      for (dynamic item in responseMap['tracks']['items']){
        print("Found id song ${item['track']['id']}");
        listIdSongs.add(item['track']['id']);
      }
      return listIdSongs;
    } else {
      throw Exception('Failed to load playlist');
    }
  }
}

class MusicApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/tracks/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Music> fetchMusic(String musicId) async{
    final response = await http.get(
      Uri.parse('$_baseUrl$musicId'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Music music = Music.fromMap(responseMap);
      music.songColor = await getImagePalette(NetworkImage(music.songImage ?? "default_image_url"));
      Artists artist = await ArtistApi().fetchArtist(responseMap['album']['artists'][0]['id']);
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

class ArtistApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/artists/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Artists> fetchArtist(String artistId) async{
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
}

class AlbumApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/albums/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Albums> fetchAlbum(String albumId) async{
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
      return album;
    } else {
      throw Exception('Failed to load playlist');
    }
  }
}

class SearchApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/search';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<List<Music>> searchTracks(String query) async{
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
          PlaylistModel playlistData = await PlaylistApi.fetchPlaylist(item['id']);
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