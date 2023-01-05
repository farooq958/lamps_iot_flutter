import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/MainScreenViews/main_screen.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/PageTransitions/slide_page_transition.dart';

class IntroForwardButton extends StatelessWidget {
  final int? introPageState;

  const IntroForwardButton({
    super.key,
    required this.introPageState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 32.sp),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (introPageState != 2) {
            Repository.onBoardingSelectedPage.nextPage(
              duration: const Duration(
                milliseconds: 700,
              ),
              curve: Curves.easeInOut,
            );
            SharedPrefs.setInitPage(initPage: 'installed');
          } else {
            Navigator.push(
              context,
              CustomSlidePageRoute(
                child: const MainScreen(),
                direction: AxisDirection.left,
              ),
            );
          }
        },
        child: Container(
          height: 40.sp,
          width: 40.sp,
          decoration: const BoxDecoration(
            color: AppColors.yellow,
            shape: BoxShape.circle,
          ),
          child: Icon(
            introPageState == 2 ? Icons.check : Icons.arrow_forward,
            color: AppColors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
