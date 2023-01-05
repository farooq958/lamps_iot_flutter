import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Controllers/Cubits/default_colors_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';

class DefinedColors extends StatelessWidget {
  // final bool? power;
  final bool? theme;

  const DefinedColors({
    super.key,
    // required this.power,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultColorsCubit, int?>(
      builder: (context, defaultColorState) {
        return Container(
          // height: 50.sp,
          // width: 1.sw,
          color: theme! ? AppColors.white : AppColors.themeBlack,
          padding: EdgeInsets.symmetric(horizontal: 32.sp, vertical: 0.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (SharedPrefs.getDefaultColorIndex() == null) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                    if (SharedPrefs.getDefaultColorIndex() != 1) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 1);
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 1);

                      //remove the fav color form shared pref
                      SharedPrefs.setFavoriteColorIndex(favoriteColorIndex: -1);

                      if (SharedPrefs.getColor() == null) {
                        SharedPrefs.setColor(
                            color: const Color(0xfffffffE).value);
                      } else {
                        SharedPrefs.setColor(
                            color: const Color(0xfffffffE).value);
                      }

                      // //backend operation
                      String? redColorValue =
                          Color(SharedPrefs.getColor()!).red.toString();
                      String? greenColorValue =
                          Color(SharedPrefs.getColor()!).green.toString();
                      String? blueColorValue =
                          Color(SharedPrefs.getColor()!).blue.toString();
                      // String? opacity =
                      //     Color(SharedPrefs.getColor()!).alpha.toString();
                      debugPrint('red =>$redColorValue');
                      debugPrint('green =>$greenColorValue');
                      debugPrint('blue =>$blueColorValue');
                      // debugPrint('opacity =>$opacity');
                      Repository.setColor(
                        context: context,
                        gatewayIP: Repository.wifiGateWayIP,
                        red: redColorValue,
                        green: greenColorValue,
                        blue: blueColorValue,
                        // opacity: opacity,
                      );
                    } else {
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 0);
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                  },
                  child: Container(
                    height: 48.sp,
                    width: 48.sp,
                    decoration: BoxDecoration(
                      color: const Color(0xfffffffE),
                      shape: BoxShape.circle,
                      border: theme!
                          ? Border.all(
                              width: 1.sp,
                              color: Colors.black12,
                            )
                          : Border.all(
                              width: 0.sp,
                              color: Colors.transparent,
                            ),
                    ),
                    child: SharedPrefs.getDefaultColorIndex() == 1
                        ? Icon(
                            Icons.check,
                            size: 14.sp,
                            color: Colors.black,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 1,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (SharedPrefs.getDefaultColorIndex() == null) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                    if (SharedPrefs.getDefaultColorIndex() != 2) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 2);
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 1);

                      //remove the fav color form shared pref
                      SharedPrefs.setFavoriteColorIndex(favoriteColorIndex: -1);

                      if (SharedPrefs.getColor() == null) {
                        SharedPrefs.setColor(
                            color: const Color(0xff00000E).value);
                      } else {
                        SharedPrefs.setColor(
                            color: const Color(0xff00000E).value);
                      }

                      // //backend operation
                      String? redColorValue =
                          Color(SharedPrefs.getColor()!).red.toString();
                      String? greenColorValue =
                          Color(SharedPrefs.getColor()!).green.toString();
                      String? blueColorValue =
                          Color(SharedPrefs.getColor()!).blue.toString();
                      // String? opacity =
                      //     Color(SharedPrefs.getColor()!).alpha.toString();
                      debugPrint('red =>$redColorValue');
                      debugPrint('green =>$greenColorValue');
                      debugPrint('blue =>$blueColorValue');
                      // debugPrint('opacity =>$opacity');
                      Repository.setColor(
                        context: context,
                        gatewayIP: Repository.wifiGateWayIP,
                        red: redColorValue,
                        green: greenColorValue,
                        blue: blueColorValue,
                        // opacity: opacity,
                      );
                    } else {
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 0);
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                  },
                  child: Container(
                    height: 48.sp,
                    width: 48.sp,
                    decoration: BoxDecoration(
                      color: const Color(0xf0000001),
                      shape: BoxShape.circle,
                      border: theme!
                          ? Border.all(
                              width: 1.sp,
                              color: Colors.black12,
                            )
                          : Border.all(
                              width: 0.sp,
                              color: Colors.white,
                            ),
                    ),
                    child: SharedPrefs.getDefaultColorIndex() == 2
                        ? Icon(
                            Icons.check,
                            size: 14.sp,
                            color: Colors.white,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 1,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (SharedPrefs.getDefaultColorIndex() == null) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                    if (SharedPrefs.getDefaultColorIndex() != 3) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 3);
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 1);

                      //remove the fav color form shared pref
                      SharedPrefs.setFavoriteColorIndex(favoriteColorIndex: -1);

                      if (SharedPrefs.getColor() == null) {
                        SharedPrefs.setColor(
                            color: const Color(0xffff0000).value);
                      } else {
                        SharedPrefs.setColor(
                            color: const Color(0xffff0000).value);
                      }

                      // //backend operation
                      String? redColorValue =
                          Color(SharedPrefs.getColor()!).red.toString();
                      String? greenColorValue =
                          Color(SharedPrefs.getColor()!).green.toString();
                      String? blueColorValue =
                          Color(SharedPrefs.getColor()!).blue.toString();
                      // String? opacity =
                      //     Color(SharedPrefs.getColor()!).alpha.toString();
                      debugPrint('red =>$redColorValue');
                      debugPrint('green =>$greenColorValue');
                      debugPrint('blue =>$blueColorValue');
                      // debugPrint('opacity =>$opacity');
                      Repository.setColor(
                        context: context,
                        gatewayIP: Repository.wifiGateWayIP,
                        red: redColorValue,
                        green: greenColorValue,
                        blue: blueColorValue,
                        // opacity: opacity,
                      );
                    } else {
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 0);
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                  },
                  child: Container(
                    height: 48.sp,
                    width: 48.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xffFF0000),
                      shape: BoxShape.circle,
                    ),
                    child: SharedPrefs.getDefaultColorIndex() == 3
                        ? Icon(
                            Icons.check,
                            size: 14.sp,
                            color: Colors.white,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 1,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (SharedPrefs.getDefaultColorIndex() == null) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                    if (SharedPrefs.getDefaultColorIndex() != 4) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 4);
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 1);

                      //remove the fav color form shared pref
                      SharedPrefs.setFavoriteColorIndex(favoriteColorIndex: -1);

                      if (SharedPrefs.getColor() == null) {
                        SharedPrefs.setColor(
                            color: const Color(0xff00ff00).value);
                      } else {
                        SharedPrefs.setColor(
                            color: const Color(0xff00ff00).value);
                      }

                      // //backend operation
                      String? redColorValue =
                          Color(SharedPrefs.getColor()!).red.toString();
                      String? greenColorValue =
                          Color(SharedPrefs.getColor()!).green.toString();
                      String? blueColorValue =
                          Color(SharedPrefs.getColor()!).blue.toString();
                      // String? opacity =
                      //     Color(SharedPrefs.getColor()!).alpha.toString();
                      debugPrint('red =>$redColorValue');
                      debugPrint('green =>$greenColorValue');
                      debugPrint('blue =>$blueColorValue');
                      // debugPrint('opacity =>$opacity');
                      Repository.setColor(
                        context: context,
                        gatewayIP: Repository.wifiGateWayIP,
                        red: redColorValue,
                        green: greenColorValue,
                        blue: blueColorValue,
                        // opacity: opacity,
                      );
                    } else {
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 0);
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                  },
                  child: Container(
                    height: 48.sp,
                    width: 48.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xff00FF00),
                      shape: BoxShape.circle,
                    ),
                    child: SharedPrefs.getDefaultColorIndex() == 4
                        ? Icon(
                            Icons.check,
                            size: 14.sp,
                            color: Colors.white,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 1,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (SharedPrefs.getDefaultColorIndex() == null) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                    if (SharedPrefs.getDefaultColorIndex() != 5) {
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 5);
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 1);

                      //remove the fav color form shared pref
                      SharedPrefs.setFavoriteColorIndex(favoriteColorIndex: -1);

                      if (SharedPrefs.getColor() == null) {
                        SharedPrefs.setColor(
                            color: const Color(0xff0000ff).value);
                      } else {
                        SharedPrefs.setColor(
                            color: const Color(0xff0000ff).value);
                      }

                      // //backend operation
                      String? redColorValue =
                          Color(SharedPrefs.getColor()!).red.toString();
                      String? greenColorValue =
                          Color(SharedPrefs.getColor()!).green.toString();
                      String? blueColorValue =
                          Color(SharedPrefs.getColor()!).blue.toString();
                      // String? opacity =
                      //     Color(SharedPrefs.getColor()!).alpha.toString();
                      debugPrint('red =>$redColorValue');
                      debugPrint('green =>$greenColorValue');
                      debugPrint('blue =>$blueColorValue');
                      // debugPrint('opacity =>$opacity');
                      Repository.setColor(
                        context: context,
                        gatewayIP: Repository.wifiGateWayIP,
                        red: redColorValue,
                        green: greenColorValue,
                        blue: blueColorValue,
                        // opacity: opacity,
                      );
                    } else {
                      // context
                      //     .read<DefaultColorsCubit>()
                      //     .colorIndex(colorIndex: 0);
                      SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);
                    }
                  },
                  child: Container(
                    height: 48.sp,
                    width: 48.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xff0000FF),
                      shape: BoxShape.circle,
                    ),
                    child: SharedPrefs.getDefaultColorIndex() == 5
                        ? Icon(
                            Icons.check,
                            size: 14.sp,
                            color: Colors.white,
                          )
                        : const SizedBox(),
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
