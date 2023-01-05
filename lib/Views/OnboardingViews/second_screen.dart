import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_images.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';

class SecondScreen extends StatelessWidget {
  final int? introPageState;

  const SecondScreen({super.key, required this.introPageState});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppColors.white,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 50.sp),

          //image
          Container(
            height: 300.3.sp,
            padding: EdgeInsets.symmetric(horizontal: 50.sp),
            child: Image.asset(
              AppImages.intro_02,
            ),
          ),
          SizedBox(height: 58.sp),

          //title
          Container(
            padding: EdgeInsets.only(left: 54.sp),
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.introSecondTitle,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: 25.sp,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(height: 9.0.sp),

          //description
          Container(
            padding: EdgeInsets.only(left: 55.sp),
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.introSecondDescription,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(height: 31.0.sp),
        ],
      ),
    );
  }
}
