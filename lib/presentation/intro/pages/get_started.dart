import 'package:flutter/material.dart';
import 'package:spotify_group7/common/widget/button/basicButton.dart';
import 'package:spotify_group7/core/config/theme/appColors.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: BoxDecoration(
                image: DecorationImage(
                    repeat: ImageRepeat.repeatY,
                    image: AssetImage(
                      "assets/images/intro_bg.png",
                    ))),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.1,
                  0.3
                ],
                colors: <Color>[
                  AppColors.darkBG,
                  AppColors.darkBG,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Gradien bawah ke atas
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [
                  0.0,
                  0.2,
                  0.4
                ],
                colors: <Color>[
                  AppColors.darkBG,
                  AppColors.darkBG,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/spotify_logo.png",
                    height: 75,
                    width: 150,
                  ),
                ),
                Spacer(),
                Text(
                  "Music for everyone",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis ullamco cillum dolor. Voluptate exercitation incididunt aliquip deserunt reprehenderit elit laborum. ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                BasicButton(onPressed: () {}, title: "Get Started")
              ],
            ),
          )
        ],
      ),
    );
  }
}
