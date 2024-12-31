import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/constant/string.dart';
import 'package:spotify_group7/presentation/home/home.dart';
import 'package:spotify_group7/presentation/login/not_user.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final WebViewController _controller;
  String scope = 'playlist-read-private playlist-modify-private playlist-modify-public ugc-image-upload user-read-email user-read-private user-follow-modify user-follow-read user-library-modify user-library-read user-top-read';

  @override
  void initState(){
    super.initState();
    final WebViewController controller = WebViewController();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange urlChange) {},
          onNavigationRequest: (NavigationRequest request) async {
            String redirectUrl = 'myapp://spotify-login/callback';
            if (request.url.contains("${redirectUrl}?code")) {
              _controller.loadRequest(Uri.parse("about:blank"));

              final Uri uri = Uri.parse(request.url);
              String? code = uri.queryParameters['code'];

              if (code != null) {
                bool isSuccess = await _exchangeCodeForToken(code);

                if (isSuccess) {
                  bool isUser = await getUserInfo();
                  if (isUser){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } else{
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => NotUser()),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to login')),
                  );
                }
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(
          'https://accounts.spotify.com/authorize?response_type=code&client_id=${CustomStrings.clientId}&scope=$scope&redirect_uri=${CustomStrings.redirectUri}&state=y82W1K5FlTLQJiQE'));
    _controller = controller;
  }

  Future<bool> _exchangeCodeForToken(String code) async {

    final String credentials =
    base64Encode(utf8.encode('${CustomStrings.clientId}:${CustomStrings.clientSecret}'));

    final Uri tokenUri = Uri.parse('https://accounts.spotify.com/api/token');

    try {
      final response = await http.post(
        tokenUri,
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': CustomStrings.redirectUri,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        CustomStrings.accessToken = data['access_token'];
        CustomStrings.refreshToken = data['refresh_token'];
        return true;
      } else {
        print('Failed to exchange token: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during token exchange: $e');
      return false;
    }
  }

  Future<bool> getUserInfo() async{
    String _authToken = 'Bearer ${CustomStrings.accessToken}';
    String url = 'https://api.spotify.com/v1/me';
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': _authToken,
        },
      );
      print("url: $url");

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return false;
      }
    } catch(e){
      print(e);
      return false;
    }
  }

  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
