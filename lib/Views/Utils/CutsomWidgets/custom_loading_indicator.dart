import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final bool? theme;

  const CustomLoadingIndicator({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.sp,
      padding: EdgeInsets.symmetric(horizontal: 180.sp, vertical: 30.sp),
      child: CircularProgressIndicator(
        color: AppColors.yellow,
        backgroundColor: theme! ? AppColors.white : AppColors.themeBlack,
      ),
    );
    ;
  }
}
