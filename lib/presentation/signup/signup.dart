import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/image_col.dart';
import 'package:spotify_group7/design_system/styles/typograph_col.dart';
import 'package:spotify_group7/design_system/widgets/button/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                BasicButton(
                  title: 'Sign Up Free',
                  onPressed: () {},
                  height: 40,
                  backgroundColor: AppColors.buttonColor,
                  textColor: AppColors.darkBG,
                  textStyle: TypographCol.h2,
                  borderRadius: 80,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30.0),
                  elevation: 4.0,
                ),
                SizedBox(
                  height: 10,
                ),
                buildOptionButton(
                  icon: Icons.phone,
                  text: "Continue with phone number",
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                buildOptionButton(
                  icon: Icons.g_mobiledata,
                  text: "Continue with Google",
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                buildOptionButton(
                  icon: Icons.facebook,
                  text: "Continue with Facebook",
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                BasicButton(
                  title: 'Log In',
                  onPressed: () {},
                  height: 40,
                  backgroundColor: AppColors.darkBG,
                  textColor: AppColors.whiteBG,
                  textStyle: TypographCol.h2,
                  borderRadius: 80,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30.0),
                  elevation: 4.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildOptionButton({
  required IconData icon,
  required String text,
  required VoidCallback onPressed,
}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.white, width: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
