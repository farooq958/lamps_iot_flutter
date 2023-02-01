import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Views/AudioPlayerViews/main_audio_player_screen.dart';
import 'package:keptua/Views/MainScreenViews/favorite_colors_screen.dart';
import 'package:keptua/Views/MainScreenViews/main_screen.dart';
import 'package:keptua/Views/OnboardingViews/onboarding_pageview.dart';
import 'package:keptua/Views/Utils/Data/app_images.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/PageTransitions/scale_page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        Navigator.push(
          context,
          ScalePageTransition.scalePageTransition(
            page: SharedPrefs.getInitPage() == null
                ? const IntroductionPageView()
                // : SharedPrefs.getInitPage() == 'favorite_colors_screen'
                //     ? FavoriteColorsScreen(
                //         theme: SharedPrefs.getTheme(),
                //       )
                //     : SharedPrefs.getInitPage() == 'audio'
                //         ? MainAudioPlayerScreen(
                //             theme: SharedPrefs.getTheme(),
                //           )
                        : const MainScreen(),
            alignment: Alignment.center,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            )),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: 200.sp,
            right: 70.sp,
            left: 70.sp,
          ),
          children: [
            Image.asset(
              AppImages.logo,
              height: 165.04.sp,
              width: 272.79.sp,
            ),
          ],
        ),
      ),
    );
  }
}
