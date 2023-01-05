import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/onboarding_page_index_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/OnboardingViews/first_screen.dart';
import 'package:keptua/Views/OnboardingViews/last_screen.dart';
import 'package:keptua/Views/OnboardingViews/second_screen.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/onboarding_forward_button.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPageView extends StatefulWidget {
  const IntroductionPageView({super.key});

  @override
  State<IntroductionPageView> createState() => _IntroductionPageViewState();
}

class _IntroductionPageViewState extends State<IntroductionPageView> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Repository.onBoardingSelectedPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingPageIndexCubit, int?>(
      builder: (context, introPageState) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Stack(
            children: [
              //content
              Positioned(
                top: 130.sp,
                right: 0.sp,
                left: 0.sp,
                child: SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: PageView(
                    controller: Repository.onBoardingSelectedPage,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      context
                          .read<OnboardingPageIndexCubit>()
                          .setIndex(index: index);
                    },
                    children: [
                      FirstScreen(introPageState: introPageState),
                      SecondScreen(introPageState: introPageState),
                      LastScreen(introPageState: introPageState),
                    ],
                  ),
                ),
              ),

              //smooth indicators
              Positioned(
                bottom: 180.sp,
                right: 0.sp,
                left: 0.sp,
                child: Container(
                  color: AppColors.white,
                  height: 16.sp,
                  width: 1.sw,
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: Repository.onBoardingSelectedPage,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.yellow,
                      spacing: 5.sp,
                      dotColor: AppColors.grey,
                      paintStyle: PaintingStyle.fill,
                      dotHeight: 7.sp,
                      dotWidth: 15.sp,
                    ),
                    onDotClicked: (index) {
                      if (index == 0) {
                        Repository.onBoardingSelectedPage.animateToPage(
                          0,
                          duration: const Duration(
                            seconds: 1,
                          ),
                          curve: Curves.easeInOut,
                        );
                        context
                            .read<OnboardingPageIndexCubit>()
                            .setIndex(index: index);
                      } else if (index == 1) {
                        Repository.onBoardingSelectedPage.animateToPage(
                          1,
                          duration: const Duration(
                            seconds: 1,
                          ),
                          curve: Curves.easeInOut,
                        );
                        context
                            .read<OnboardingPageIndexCubit>()
                            .setIndex(index: index);
                      } else if (index == 2) {
                        Repository.onBoardingSelectedPage.animateToPage(
                          2,
                          duration: const Duration(
                            seconds: 1,
                          ),
                          curve: Curves.easeInOut,
                        );
                        context
                            .read<OnboardingPageIndexCubit>()
                            .setIndex(index: index);
                      }
                    },
                  ),
                ),
              ),

              //back button
              Positioned(
                bottom: 90.sp,
                left: 30.sp,
                right: 0.sp,
                child: introPageState == 0
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          Repository.onBoardingSelectedPage.previousPage(
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          'Back',
                          style: GoogleFonts.inter(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
              ),

              //forward button
              Positioned(
                bottom: 90.sp,
                left: 30.sp,
                right: 0.sp,
                child: IntroForwardButton(
                  introPageState: introPageState,
                ),
              ),

              ///skip button
              Positioned(
                top: 50.sp,
                right: 0.sp,
                left: 0.sp,
                child: Container(
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
