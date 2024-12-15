import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_group7/data/models/music.dart';
import 'package:spotify_group7/data/models/playlist.dart';
import 'package:spotify_group7/data/models/users.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'package:palette_generator/palette_generator.dart';
import '../models/album.dart';
import '../models/artists.dart';

class PlaylistApi {
  static const String _baseUrl = 'https://api.spotify.com/v1/playlists/';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  static Future<PlaylistModel> fetchPlaylist(String playlistId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$playlistId'),
      headers: {
        'Authorization': _authToken,
      },
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      if (responseMap['tracks'] is Map<String, dynamic>) {
        int totalTracks = responseMap['tracks']['total'] ?? 0;
        print("Total tracks: $totalTracks");

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
        print(responseMap['id']);
        print(responseMap['owner']['id']);
        print(responseMap['tracks']['total']);
        if (responseMap['images'] != null) {
          print("'${responseMap['images'][0]['url']}'");
        }
        if (responseMap['tracks'] == null || responseMap['tracks']['items'].isEmpty) {
          print('null');
        } else {
          print("ada");
        }
        PlaylistModel playlist = PlaylistModel.fromMap(responseMap);
        playlist.musics = totalTracks > 0
            ? musics
            : null;
        return playlist;
      } else {
        throw Exception('Invalid tracks data format');
      }
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

  Future<List<Music>> fetchArtistTracks(String artistId) async{
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/artists/$artistId/top-tracks'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<Music> loadedMusic = [];
      for (var item in responseMap['tracks']){
        Music musicData = Music.fromMap(item);
        loadedMusic.add(musicData);
      }
      return loadedMusic;
    } else {
      throw Exception('Failed to load playlist');
    }
  }

  Future<List<Albums>> fetchArtistAlbums(String artistId) async{
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/artists/$artistId/albums'),
      headers: {
        'Authorization': _authToken,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<Albums> loadedAlbum = [];
      for (var item in responseMap['items']){
        Albums albumData = Albums.fromMap(item);
        loadedAlbum.add(albumData);
      }
      return loadedAlbum;
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
      if (album.musics == []){
        print("music album null");
      }
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

class UserApi {
  static const String url = 'https://api.spotify.com/v1/me';

  static String _authToken = 'Bearer ${CustomStrings.accessToken}';

  Future<Users> getUserInfo() async{

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

      for (var item in items){
        print(item['id']);
        loadedPlaylist.add(item['id']);
      }

      return loadedPlaylist;
    } else {
      print('Failed to load playlists');
      throw Exception('Failed to load user playlists');
    }
  }

  Future<void> createPlaylist(String userId, String playlistName, String playlistDescription, bool isPublic) async {
    final String endPoint = 'https://api.spotify.com/v1/users/$userId/playlists';
    final Map<String, dynamic> body = {
      'name': playlistName,
      'description': playlistDescription,
      'public': isPublic
    };

    try {
      if (_authToken.isEmpty) {
        throw Exception('Auth token is null or empty');
      }
      final response = await http.post(
        Uri.parse(endPoint),
        headers: {
          'Authorization': _authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body)
      );

      if (response.statusCode == 201) {
        print("Playlist berhasil dibuat");
      } else {
        print("playlist gagal dibuat");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Music>> getTopTracks() async{
    String url = 'https://api.spotify.com/v1/me/top/tracks?time_range=short_term&limit=5';

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

  Future<List<Artists>> getTopArtists() async{
    String url = 'https://api.spotify.com/v1/me/top/artists?time_range=short_term&limit=5';

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
}