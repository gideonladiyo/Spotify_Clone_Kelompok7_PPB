import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/image_col.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';
import 'package:spotify_group7/design_system/widgets/button/custom_button.dart';
import 'package:spotify_group7/presentation/choose_mode/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding:const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [
                  0.0,
                  0.3,
                  0.5
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
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40
            ),
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
                  "Music for everyone",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: PaddingCol.lg,
                ),
                Text(
                  "Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis ullamco cillum dolor. Voluptate exercitation incididunt aliquip deserunt reprehenderit elit laborum. ",
                  style: TypographCol.p1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: PaddingCol.xxxl,
                ),
                BasicButton(
                  title: 'Get Started',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => const ChooseModePage()
                    ));
                  },
                  height: 72,
                  backgroundColor: AppColors.buttonColor,
                  textColor: AppColors.darkBG,
                  textStyle:
                      TypographCol.h1,
                  borderRadius: 80,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
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
