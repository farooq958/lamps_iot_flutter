import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';

class CustomNoSongFoundDesign extends StatelessWidget {
  final bool? theme;

  const CustomNoSongFoundDesign({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.all(60.sp),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.themeBlack,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Icon(
            Icons.info_outline,
            size: 100.sp,
            color: AppColors.yellow,
          ),
          Container(
            height: 5.sp,
            color: theme! ? AppColors.white : AppColors.themeBlack,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'No Songs Found',
              style: GoogleFonts.poppins(
                fontSize: 25.sp,
                color: AppColors.yellow,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
