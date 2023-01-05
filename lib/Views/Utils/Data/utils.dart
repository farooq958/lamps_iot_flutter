import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';

class Utils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required bool theme,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: theme ? AppColors.yellow : AppColors.themeBlack,
      content: SizedBox(
        height: 50.sp,
        width: 1.sw,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: LinearProgressIndicator(
                color: AppColors.white,
                minHeight: 5.sp,
                backgroundColor: AppColors.yellow,
                semanticsLabel: message,
              ),
            ),
            Expanded(
              flex: 15,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showCustomSnackBar({
    required BuildContext context,
    required String message,
    required bool theme,
  }) {
    final customSnackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 20.sp,
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: theme ? AppColors.yellow : AppColors.themeBlack,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(customSnackBar);
  }
}
