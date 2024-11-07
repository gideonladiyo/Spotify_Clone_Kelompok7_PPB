import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/image_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';
import 'package:spotify_group7/design_system/widgets/button/custom_button.dart';
import 'package:spotify_group7/presentation/home/home.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBG,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    repeat: ImageRepeat.repeatY,
                    image: AssetImage(
                      AppImages.intro_bg,
                    ))),
          ),
          Container(
            decoration: const BoxDecoration(
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
            decoration: const BoxDecoration(
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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
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
                const Spacer(),
                const Text(
                  "Choose mode",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteBG,
                  ),
                ),
                const SizedBox(
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
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppImages.bulan)),
                              color: Color(0xff111111),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Dark Mode",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppImages.matahari)),
                              color: Color(0xff333333),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Light Mode",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                BasicButton(
                  title: 'Get Started',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomePages()));
                  },
                  height: 72,
                  backgroundColor: AppColors.buttonColor,
                  textColor: AppColors.darkBG,
                  textStyle: TypographCol.h1,
                  borderRadius: 80,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30.0),
                  elevation: 4.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
