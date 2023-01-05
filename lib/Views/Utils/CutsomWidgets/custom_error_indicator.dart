import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_images.dart';

class CustomErrorIndicator extends StatelessWidget {
  final bool? theme;

  const CustomErrorIndicator({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme! ? AppColors.white : AppColors.themeBlack,
      padding: EdgeInsets.symmetric(horizontal: 32.sp),
      child: Container(
        height: 120.sp,
        width: 1.sw,
        decoration: BoxDecoration(
          color: theme! ? AppColors.white : AppColors.themeBlack,
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            color: AppColors.yellow,
            width: 1.sp,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: Image.asset(
                AppImages.warning,
              ),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 3,
              child: Text(
                'Error while fetching favorite colors',
                style: GoogleFonts.poppins(
                  color: AppColors.yellow,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
