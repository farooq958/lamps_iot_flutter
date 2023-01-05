import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';

class CustomAppBar extends StatelessWidget {
  final bool? power;

  final String? wifiGatewayIP;

  const CustomAppBar({
    super.key,
    required this.power,
    required this.wifiGatewayIP,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: SharedPrefs.getTheme() == true || SharedPrefs.getTheme() == null
          ? AppColors.white
          : AppColors.themeBlack,
      padding: EdgeInsets.symmetric(horizontal: 30.sp),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (wifiGatewayIP == '0.0.0.0') {
                  if (SharedPrefs.getPower() == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        backgroundColor: SharedPrefs.getTheme() == true ||
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
                                  color: SharedPrefs.getTheme() == true ||
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
                        backgroundColor: SharedPrefs.getTheme() == true ||
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
                                  color: SharedPrefs.getTheme() == true ||
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
                  } else if (SharedPrefs.getPower() == true && power == true) {
                    SharedPrefs.setPower(power: false);
                  }
                } else if (wifiGatewayIP != '0.0.0.0') {
                  if (SharedPrefs.getPower() == true) {
                    SharedPrefs.setPower(power: false);
                    Repository.power(
                        status: false, gatewayIP: Repository.wifiGateWayIP);
                  } else if (SharedPrefs.getPower() == null) {
                    SharedPrefs.setPower(power: true);
                    Repository.power(
                        status: true, gatewayIP: Repository.wifiGateWayIP);
                  } else if (SharedPrefs.getPower() == false) {
                    SharedPrefs.setPower(power: true);
                    Repository.power(
                        status: true, gatewayIP: Repository.wifiGateWayIP);
                  }
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.power_settings_new_rounded,
                  color: power! ? AppColors.green : AppColors.yellow,
                ),
              ),
            ),
          ),
          const Spacer(flex: 8),
          Expanded(
            flex: 1,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                debugPrint('initial theme ${SharedPrefs.getTheme()}');
                if (SharedPrefs.getTheme() == null) {
                  // context.read<ThemeCubit>().selectedTheme(false);
                  SharedPrefs.setTheme(theme: true);
                  debugPrint('theme set to ${SharedPrefs.getTheme()}');
                } else if (SharedPrefs.getTheme() == true) {
                  // context.read<ThemeCubit>().selectedTheme(true);
                  SharedPrefs.setTheme(theme: false);
                  debugPrint('theme set to ${SharedPrefs.getTheme()}');
                } else if (SharedPrefs.getTheme()! == false) {
                  SharedPrefs.setTheme(theme: true);
                  debugPrint('theme set to ${SharedPrefs.getTheme()}');
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  SharedPrefs.getTheme() == true ||
                          SharedPrefs.getTheme() == null
                      ? Icons.mode_night_outlined
                      : Icons.sunny,
                  //sunny //mode_night_outlined
                  color: SharedPrefs.getTheme() == true ||
                          SharedPrefs.getTheme() == null
                      ? AppColors.black
                      : AppColors.yellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
