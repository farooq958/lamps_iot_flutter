import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Views/AudioPlayerViews/main_audio_player_screen.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';
import 'package:keptua/Views/Utils/PageTransitions/slide_page_transition.dart';

class MusicButton extends StatelessWidget {
  final bool? power;
  final bool? theme;

  const MusicButton({super.key, required this.power, required this.theme});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        //set shared preference
        SharedPrefs.setInitPage(initPage: 'audio');
        //Navigate to audio player
        Navigator.push(
          context,
          CustomSlidePageRoute(
            direction: AxisDirection.left,
            child: MainAudioPlayerScreen(
              theme: theme!,
            ),
          ),
        );
      },
      child: Container(
        height: 55.sp,
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 20.sp),
        decoration: BoxDecoration(
          color: theme! ? AppColors.white : AppColors.themeBlack,
          borderRadius: BorderRadius.circular(18.sp),
          border: Border.all(
            width: 2.sp,
            color:
                SharedPrefs.getTheme() == true || SharedPrefs.getTheme() == null
                    ? AppColors.yellow
                    : AppColors.yellow,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 52.sp,
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 9.sp),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.yellow,
                        width: 2.sp,
                      )),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.yellow,
                    size: 22.sp,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                height: 52.sp,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  AppStrings.musicButtonText,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: AppColors.yellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
