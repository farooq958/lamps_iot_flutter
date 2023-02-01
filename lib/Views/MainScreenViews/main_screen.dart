import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/power_cubit.dart';
import 'package:keptua/Controllers/Cubits/theme_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/app_bar.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/circle_color_picker.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/defined_colors.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/music_button.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/operation_button.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/start_page.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/user_favorite_colors.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:showcaseview/showcaseview.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String connectionStatus = 'Unknown';
  final NetworkInfo networkInfo = NetworkInfo();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _first = GlobalKey();
  final GlobalKey _second = GlobalKey();
  final GlobalKey _third = GlobalKey();
  final GlobalKey _fourth = GlobalKey();
  final GlobalKey _fifth = GlobalKey();
  @override
  void initState() {
    super.initState();
    initNetworkInfo();
    requestPermission();
    // WidgetsBinding.instance.addPostFrameCallback(
    //       (_) => ShowCaseWidget.of(context)
    //       .startShowCase([_first, _second,_third,_fourth]),
    //);
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context)
            .startShowCase([_first, _second,_third,_fourth,_fifth]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PowerCubit, bool>(builder: (context, powerState) {
      return BlocBuilder<ThemeCubit, bool>(
        builder: (context, theme) {
          return WillPopScope(
            onWillPop: () async {
              bool response = Repository.appExit(
                  context: context, theme: SharedPrefs.getTheme()!);
              return response;
            },
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: SharedPrefs.getTheme() == true ||
                      SharedPrefs.getTheme() == null
                  ? AppColors.white
                  : AppColors.themeBlack,
              appBar: AppBar(
                elevation: 0,

                backgroundColor: SharedPrefs.getTheme() == true ||
                        SharedPrefs.getTheme() == null
                    ? AppColors.white
                    : AppColors.themeBlack,
                actions: [
                  CustomAppBar(
                    key1:_first,
                    power: powerState,
                    wifiGatewayIP: connectionStatus,
                    // networkInfo: initNetworkInfo(),
                  ),
                ],
              ),
              body: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 1.sh,
                        width: 1.sw,
                        color: SharedPrefs.getTheme() == true ||
                            SharedPrefs.getTheme() == null
                            ? AppColors.white
                            : AppColors.themeBlack,
                        //color: AppColors.white,
                        child: ScrollConfiguration(
                          behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                          child:  ListView(
                              padding: EdgeInsets.zero,
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                CircleColorPicker(
                                  key1:_second,
                                  key2:_third,
                                  // power: powerState,
                                  theme: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null,
                                  //   scaffoldKey: _scaffoldKey,
                                )

//SizedBox(height: 30.sp,),
                                ,   //pre defined colors
                                DefinedColors(
                                  // power: powerState,
                                  theme: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null,
                                ),
                                Container(
                                  height: 15.sp,
                                  padding: EdgeInsets.zero,
                                  color: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null
                                      ? AppColors.white
                                      : AppColors.themeBlack,
                                ),

                                //block Color Picker
                                // const BlockColorPicker(),

                                //user Favorite Colors
                                UserFavoriteColors(
                                  key3:_fourth,
                                  key4:_fifth,
                                  theme: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null,
                                ),

                                Container(
                                  height: 5.sp,
                                  color: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null
                                      ? AppColors.white
                                      : AppColors.themeBlack,
                                ),

                                //custom opacity container
                                // CustomOpacityContainer(
                                //   theme: SharedPrefs.getTheme() == true ||
                                //       SharedPrefs.getTheme() == null,
                                // ),
                                Container(
                                  height: 20.sp,
                                  padding: EdgeInsets.zero,
                                  color: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null
                                      ? AppColors.white
                                      : AppColors.themeBlack,
                                ),

                                //audio player button
                                MusicButton(
                                  power: powerState,
                                  theme: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null,
                                ),
                                Container(
                                  height: 20.sp,
                                  padding: EdgeInsets.zero,
                                  color: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null
                                      ? AppColors.white
                                      : AppColors.themeBlack,
                                ),

                                //operations button
                                OperationButtons(
                                  power: powerState,
                                  theme: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null,
                                ),
                                Container(
                                  height: 70.sp,
                                  padding: EdgeInsets.zero,
                                  color: SharedPrefs.getTheme() == true ||
                                      SharedPrefs.getTheme() == null
                                      ? AppColors.white
                                      : AppColors.themeBlack,
                                ),
                              ],
                            )
                           ,
                        ),
                      ),
                    ),
                    Positioned(


                        bottom: 0,
                        child: Container(color:SharedPrefs.getTheme() == true ||
                            SharedPrefs.getTheme() == null
                            ? AppColors.lightYellow
                            : AppColors.greyCopyright , height: 35.sp,width: 1.sw, child:
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(

                                child: Align( alignment: Alignment.centerRight
                                    ,child: Image.asset("assets/images/veevoCopyRightImage.png",
                                      width: 40.sp,height:22.sp ,))),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 8.0.sp),
                                  child: Text('Powered by Veevo Tech',style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 10.sp,color: AppColors.yellow),),
                                ))


                          ],
                        ), )),
                    AnimatedPositioned(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      top: SharedPrefs.getPower() == true ? -1.sh : 0,
                      left: SharedPrefs.getPower() == true ? 0 : -1.sw,
                      right: SharedPrefs.getPower() == true ? 0 : -1.sw,
                      child: StartPage(
                        theme: SharedPrefs.getTheme() == true ||
                            SharedPrefs.getTheme() == null,
                        wifiGatewayIP: connectionStatus,
                        power: powerState,
                        networkInfo: initNetworkInfo(),
                      ),
                    ),
                  ],
                )



            ),
          );
        },
      );
    });
  }
  void requestPermission() {
    Permission.storage.request();
  }
  Future<void> initNetworkInfo() async {
    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask;

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await networkInfo.getWifiName();
        } else {
          wifiName = await networkInfo.getWifiName();
        }
      } else {
        wifiName = await networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      if (!Platform.isWindows) {
        wifiIPv6 = await networkInfo.getWifiIPv6();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      if (!Platform.isWindows) {
        wifiSubmask = await networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    try {
      if (!Platform.isWindows) {
        wifiBroadcast = await networkInfo.getWifiBroadcast();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      if (!Platform.isWindows) {
        wifiGatewayIP = await networkInfo.getWifiGatewayIP();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    setState(() {
      connectionStatus = '$wifiGatewayIP';
    });

    setState((){

      Repository.wifiGateWayIP = '$wifiGatewayIP';


    });
  }
}
