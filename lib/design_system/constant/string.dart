import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomStrings {
  static const String clientId = '55a7b8fce8fa495596b839a8577ce612';
  static const String clientSecret = '07d19074fb6943978b8435a69be4c9da';
  static String? accessToken;
  static String? refreshToken;
  static String redirectUri = 'myapp://spotify-login/callback';
}