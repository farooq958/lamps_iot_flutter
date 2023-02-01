import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_images.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';

class StartPage extends StatelessWidget {
  final bool? theme;
  final String? wifiGatewayIP;
  final bool? power;
  final Future<void>? networkInfo;

  const StartPage({
    super.key,
    required this.theme,
    required this.wifiGatewayIP,
    required this.power,
    required this.networkInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: theme! ? Colors.white : AppColors.themeBlack, //on
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 32.sp),
          children: [
            Container(
              height: 80.sp,
              color: SharedPrefs.getTheme() == true ||
                      SharedPrefs.getTheme() == null
                  ? AppColors.white
                  : AppColors.themeBlack,
            ),
            Container(
              height: 342.63.sp,
              width: 339.sp,
              color: theme! ? AppColors.white : AppColors.themeBlack,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: Image.asset(
                      AppImages.introImage,
                      height: 342.63.sp,
                      width: 339.sp,
                    ),
                  ),
                  Positioned(
                    top: 115.sp,
                    left: 605.sp,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (wifiGatewayIP == '0.0.0.0') {
                          if (SharedPrefs.getPower() == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                backgroundColor:
                                    SharedPrefs.getTheme() == true ||
                                            SharedPrefs.getTheme() == null
                                        ? AppColors.yellow
                                        : AppColors.themeBlack,
                                content: SizedBox(
                                  height: 30.sp,
                                  width: 1.sw,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.wifi_off,
                                          color: SharedPrefs.getTheme() ==
                                                      true ||
                                                  SharedPrefs.getTheme() == null
                                              ? AppColors.white
                                              : AppColors.white,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Wi-Fi',
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
                              ),
                            );
                          } else if (SharedPrefs.getPower() == false &&
                              power == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                backgroundColor:
                                    SharedPrefs.getTheme() == true ||
                                            SharedPrefs.getTheme() == null
                                        ? AppColors.yellow
                                        : AppColors.themeBlack,
                                content: SizedBox(
                                  height: 30.sp,
                                  width: 1.sw,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.wifi_off,
                                          color: SharedPrefs.getTheme() ==
                                                      true ||
                                                  SharedPrefs.getTheme() == null
                                              ? AppColors.white
                                              : AppColors.white,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Wi-Fi',
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
                              ),
                            );
                          } else if (SharedPrefs.getPower() == true &&
                              power == true) {
                            SharedPrefs.setPower(power: false);
                          }
                        } else if (wifiGatewayIP != '0.0.0.0') {
                          if (SharedPrefs.getPower() == true) {
                            SharedPrefs.setPower(power: false);
                            Repository.power(
                                status: false,
                                gatewayIP: Repository.wifiGateWayIP);
                          } else if (SharedPrefs.getPower() == null) {
                            SharedPrefs.setPower(power: true);
                            Repository.power(
                                status: true,
                                gatewayIP: Repository.wifiGateWayIP);
                          } else if (SharedPrefs.getPower() == false) {
                            SharedPrefs.setPower(power: true);
                            Repository.power(
                                status: true,
                                gatewayIP: Repository.wifiGateWayIP);
                          }
                        }
                      },
                      child: Container(
                        height: 45.sp,
                        width: 45.sp,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 55.4.sp),
            Container(
              padding: EdgeInsets.only(left: 440.w),
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.introTitle,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.sp,
                  color: theme! ? AppColors.black : AppColors.white,
                ),
              ),
            ),
            SizedBox(height: 15.0.sp),
            Container(
              padding: EdgeInsets.only(left: 450.w),
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.introDescription,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: theme! ? AppColors.black : AppColors.white,
                ),
              ),
            ),
            SizedBox(height: 80.0.sp),
//             Container(
//               padding: EdgeInsets.only(left: 420.sp),
//               alignment: Alignment.centerLeft,
//               child: Text("Wifi IP Address",textAlign: TextAlign.left,style: GoogleFonts.poppins(
//                   fontSize: 10.sp,fontWeight: FontWeight.w400,
//                   color:
//               theme! ? AppColors.black : AppColors.white),),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 410.sp,right: 410.sp),
//               child: SizedBox(
//                 width: 100.sp,
//                 height: 50.sp,
//                 child: Container(
//                   padding: EdgeInsets.only(left: 10.sp),
//                   alignment: Alignment.centerLeft,
//                  // width: 351.sp,
//
//                   height: 44.sp,
//                   decoration: BoxDecoration(
//                     border: Border.all(
// color: AppColors.lightYellow
//
//                     ),
//                     borderRadius: BorderRadius.circular(14.sp)
//
//                   ),
//                   child: Text(Repository.wifiGateWayIP.toString(),
//                     style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14.sp,color: AppColors.yellow ),),
//
//                 ),
//               ),
//             )

            // Container(
            //   padding: EdgeInsets.only(left: 440.sp),
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     'Wifi IP Address',
            //     style: GoogleFonts.poppins(
            //       color: theme! ? const Color(0xff454444) : AppColors.white,
            //       fontWeight: FontWeight.w400,
            //       fontStyle: FontStyle.normal,
            //       fontSize: 10.sp,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 5.sp),
            // Container(
            //   height: 43.sp,
            //   width: 1.sw,
            //   padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            //   margin: EdgeInsets.only(left: 440.sp, right: 440.sp),
            //   alignment: Alignment.centerLeft,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: theme! ? AppColors.yellow : AppColors.white,
            //       width: 1.sp,
            //     ),
            //     borderRadius: BorderRadius.circular(12.sp),
            //   ),
            //   child: Text(
            //     wifiGatewayIP!,
            //     style: GoogleFonts.poppins(
            //       color: theme! ? AppColors.yellow : AppColors.white,
            //       fontSize: 14.sp,
            //       fontStyle: FontStyle.normal,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
