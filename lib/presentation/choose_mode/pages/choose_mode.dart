import 'package:flutter/material.dart';
import 'package:spotify_group7/common/widget/button/basicButton.dart';
import 'package:spotify_group7/core/config/assets/app_images.dart';
import 'package:spotify_group7/core/config/theme/appColors.dart';
import 'package:spotify_group7/presentation/home/pages/home.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

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
                      AppImages.intro_bg,
                    ))),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.1, 0.3],
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
                stops: [0.0, 0.3, 0.5],
                colors: <Color>[
                  AppColors.darkBG,
                  AppColors.darkBG,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    AppImages.spotify_logo,
                    height: 75,
                    width: 150,
                  ),
                ),
                Spacer(),
                Text(
                  "Choose mode",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightBG,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(AppImages.bulan)),
                              color: Color(0xff111111), shape: BoxShape.circle),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                            fontSize: 14
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(AppImages.matahari)),
                              color: Color(0xff333333), shape: BoxShape.circle),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Light Mode",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                BasicButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const HomePages()));
                    },
                    title: "Continue")
              ],
            ),
          )
        ],
      ),
    );
  }
}
