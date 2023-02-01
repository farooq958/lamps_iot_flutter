import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/AddFavoriteColorCubit/add_favorite_color_cubit.dart';
import 'package:keptua/Controllers/Cubits/DeleteColorCubit/delete_color_cubit.dart';
import 'package:keptua/Controllers/Cubits/FavoriteColorsCubits/fetch_favorite_colors_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Controllers/fetch_favorite_colors_controller.dart';
import 'package:keptua/Views/MainScreenViews/favorite_colors_screen.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/custom_error_indicator.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/custom_favorite_color_notifier.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/custom_loading_indicator.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/Data/utils.dart';
import 'package:keptua/Views/Utils/PageTransitions/scale_page_transition.dart';
import 'package:showcaseview/showcaseview.dart';

class UserFavoriteColors extends StatefulWidget {
  final bool? theme;
   GlobalKey key3 = GlobalKey();
   GlobalKey key4 = GlobalKey();
   UserFavoriteColors({
    super.key,
    required this.theme,
     required this.key3,
     required this.key4
  });

  @override
  State<UserFavoriteColors> createState() => _UserFavoriteColorsState();
}

class _UserFavoriteColorsState extends State<UserFavoriteColors> {

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //         (_) => ShowCaseWidget.of(context)
    //         .startShowCase([widget.key3,widget.key4]));
    context.read<FetchFavoriteColorsCubit>().favoriteColorsData();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFavoriteColorCubit, AddFavoriteColorState>(
      listener: (context, addingColorState) {
        if (addingColorState is AddFavoriteColorSuccess) {
    //  print("contextx"+context.toString());
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
           Utils.showCustomSnackBar(
                context: context,
                message: 'Marked as favorite',
                theme: widget.theme!,
              ),
            );
        } else if (addingColorState is AddFavoriteColorError) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              Utils.showCustomSnackBar(
                context: context,
                message: 'Sorry! something went wrong try again',
                theme: widget.theme!,
              ),
            );
        } else if (addingColorState is AddFavoriteColorFailed) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              Utils.showCustomSnackBar(
                context: context,
                message: 'Sorry! failed to mark as favorite try again',
                theme: widget.theme!,
              ),
            );
        }
      },
      child: BlocListener<DeleteColorCubit, DeleteColorState>(
        listener: (context, deleteColorState) {
          if (deleteColorState is DeleteColorSuccess) {
            SharedPrefs.setInitPage(initPage: 'installed');
            SharedPrefs.setFavoriteColorIndex(favoriteColorIndex: 0);
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(
                  'Removed from favorites',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                backgroundColor:
                    widget.theme! ? AppColors.yellow : AppColors.themeBlack,
                behavior: SnackBarBehavior.floating,
              ));
          } else if (deleteColorState is DeleteColorError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                Utils.showCustomSnackBar(
                  context: context,
                  message: 'Sorry! something went wrong try again',
                  theme: widget.theme!,
                ),
              );
          } else if (deleteColorState is DeleteColorFailed) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                Utils.showCustomSnackBar(
                  context: context,
                  message: 'Sorry! failed to remove try again',
                  theme: widget.theme!,
                ),
              );
          }
        },
        child: BlocBuilder<FetchFavoriteColorsCubit, FetchFavoriteColorsState>(
          builder: (context, fetchingFavColorsState) {
            if (fetchingFavColorsState is FetchFavoriteColorsEmpty) {
              return Showcase(key: widget.key3,
              description: 'Your Favourite color initial ',
              child: CustomFavoriteColorsNotifier(theme: widget.theme!));
            } else if (fetchingFavColorsState is FetchFavoriteColorsLoading) {
              return CustomLoadingIndicator(theme: widget.theme!);
            } else if (fetchingFavColorsState is FetchFavoriteColorsError) {
              return CustomErrorIndicator(theme: widget.theme!);
            } else if (fetchingFavColorsState is FetchFavoriteColorsInitial) {
              return CustomLoadingIndicator(theme: widget.theme!);
            } else if (fetchingFavColorsState is FetchFavoriteColorsSuccess) {
              return Showcase(
                blurValue: 0.3,
                title: "Your Favourite Color",
                key: widget.key4,
                description: 'Hold to Delete your Favourite Color',
                child: Container(
                  color: widget.theme! ? AppColors.white : AppColors.themeBlack,
                  // height: FetchFavoriteColorsController
                  //             .userFavoriteColorsList.length <=
                  //         5
                  //     ? 55.sp
                  //     : FetchFavoriteColorsController
                  //                 .userFavoriteColorsList.length <=
                  //             10
                  //         ? 122.sp
                  //         : 116.sp,
                  height: 70.sp,
                  width: 1.sw,
                  padding: EdgeInsets.only(
                    left: 32.sp,
                    right: 38.sp,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Your Favorite Colors",style: GoogleFonts.poppins(fontSize:14.sp ,fontWeight: FontWeight.w500,color: widget.theme! ? AppColors.themeBlack:AppColors.white),)),
                          //favorite colors screen
                           Expanded(
                             child: Container(
                              height: 30.sp,
                              width: 1.sw,
                              color: widget.theme!
                                  ? AppColors.white
                                  : AppColors.themeBlack,
                              alignment: Alignment.centerRight,
                              child: FetchFavoriteColorsController.userFavoriteColorsList.length<=5?
                                  const SizedBox()
                                  :
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    ScalePageTransition.scalePageTransition(
                                      page: FavoriteColorsScreen(
                                        theme: widget.theme!,
                                      ),
                                      alignment: Alignment.centerRight,
                                    ),
                                  );
                                  SharedPrefs.setInitPage(
                                      initPage: 'favorite_colors_screen');
                                },
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    color: widget.theme!
                                        ? AppColors.black
                                        : AppColors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                          ),
                           ),
                        ],
                      ),
                     // SizedBox(height: 2.sp),
                      SizedBox(
                        height: 50.sp,
                        width: 1.sw,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                         physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 38.sp,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 40.sp,
                            mainAxisSpacing: 18.sp,
                          ),
                          itemCount: FetchFavoriteColorsController
                              .userFavoriteColorsList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onLongPress: () async {
                                context
                                    .read<DeleteColorCubit>()
                                    .deleteFavoriteColor(
                                      id: FetchFavoriteColorsController
                                          .userFavoriteColorsList[index].id!,
                                    );
                                context
                                    .read<FetchFavoriteColorsCubit>()
                                    .favoriteColorsData();
                              },
                              onTap: () {
                                if (SharedPrefs.getFavoriteColorIndex() == null) {
                                  SharedPrefs.setFavoriteColorIndex(
                                      favoriteColorIndex: 0);
                                }
                                if (SharedPrefs.getFavoriteColorIndex() !=
                                    FetchFavoriteColorsController
                                        .userFavoriteColorsList[index].id) {
                                  SharedPrefs.setFavoriteColorIndex(
                                      favoriteColorIndex:
                                          FetchFavoriteColorsController
                                              .userFavoriteColorsList[index].id);

                                  SharedPrefs.setDefaultColorIndex(
                                      defaultColorIndex: 0);

                                  if (SharedPrefs.getColor() == null) {
                                    SharedPrefs.setColor(
                                        color: const Color(0xfffffffE).value);
                                  } else {
                                    SharedPrefs.setColor(
                                      color: FetchFavoriteColorsController
                                          .userFavoriteColorsList[index]
                                          .colorValue!,
                                    );
                                  }

                                  // //backend operation
                                  String? redColorValue =
                                      Color(SharedPrefs.getColor()!)
                                          .red
                                          .toString();
                                  String? greenColorValue =
                                      Color(SharedPrefs.getColor()!)
                                          .green
                                          .toString();
                                  String? blueColorValue =
                                      Color(SharedPrefs.getColor()!)
                                          .blue
                                          .toString();
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
                                  SharedPrefs.setDefaultColorIndex(
                                      defaultColorIndex: 0);
                                }
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(FetchFavoriteColorsController
                                      .userFavoriteColorsList[index].colorValue!),
                                  shape: BoxShape.circle,
                                ),
                                child: SharedPrefs.getFavoriteColorIndex() ==
                                        FetchFavoriteColorsController
                                            .userFavoriteColorsList[index].id
                                    ? Icon(
                                        Icons.check,
                                        size: 20.sp,
                                        color: Colors.grey,
                                      )
                                    : const SizedBox(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5.sp),

                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
