import '../../design_system/constant/string.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenManager {
  static const String tokenEndpoint = 'https://accounts.spotify.com/api/token';

  static Future<bool> refreshAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse(tokenEndpoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': CustomStrings.refreshToken,
          'client_id': CustomStrings.clientId,
          'client_secret': CustomStrings.clientSecret,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        CustomStrings.accessToken = responseData['access_token'];
        // Optionally update refresh token if provided
        if (responseData.containsKey('refresh_token')) {
          CustomStrings.refreshToken = responseData['refresh_token'];
        }
        return true;
      } else {
        print('Failed to refresh token: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception while refreshing token: $e');
      return false;
    }
  }
}