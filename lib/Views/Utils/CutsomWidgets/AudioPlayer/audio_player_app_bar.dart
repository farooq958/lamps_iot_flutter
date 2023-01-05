import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Views/MainScreenViews/main_screen.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_icons.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';
import 'package:keptua/Views/Utils/PageTransitions/slide_page_transition.dart';

class AudioPlayerAppBar extends StatelessWidget {
  final bool? theme;

  const AudioPlayerAppBar({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.sp,
      width: 1.sw,
      color: theme! ? AppColors.white : AppColors.themeBlack,
      padding: EdgeInsets.symmetric(horizontal: 23.sp),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                //Set Shared preference route
                SharedPrefs.setInitPage(initPage: 'installed');
                //navigate to previous screen
                Navigator.pushReplacement(
                  context,
                  CustomSlidePageRoute(
                    direction: AxisDirection.right,
                    child: const MainScreen(),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  AppIcons.back_arrow,
                  color: theme! ? AppColors.themeBlack : AppColors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Text(
              AppStrings.audioPlayerTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: theme! ? AppColors.themeBlack : AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
