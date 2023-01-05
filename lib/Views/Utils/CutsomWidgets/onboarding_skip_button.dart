import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';

class IntroSkipButton extends StatelessWidget {
  final int? introPageState;

  const IntroSkipButton({super.key, required this.introPageState});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.sp,
      width: 43.sp,
      color: AppColors.white,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 32.sp),
      child: introPageState == 2
          ? const SizedBox()
          : InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Repository.onBoardingSelectedPage.animateToPage(
                  2,
                  duration: const Duration(
                    seconds: 1,
                  ),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                AppStrings.skip,
                style: GoogleFonts.inter(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 20.sp,
                ),
              ),
            ),
    );
  }
}
