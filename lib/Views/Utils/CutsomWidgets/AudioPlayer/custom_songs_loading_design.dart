import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';

class CustomSongsLoadingDesign extends StatelessWidget {
  final bool? theme;

  const CustomSongsLoadingDesign({super.key, required this.theme});

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
      child: CircularProgressIndicator(
        color: AppColors.yellow,
        strokeWidth: 5.sp,
      ),
    );
  }
}
