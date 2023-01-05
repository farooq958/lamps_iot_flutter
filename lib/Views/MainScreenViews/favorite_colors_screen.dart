import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/DeleteColorCubit/delete_color_cubit.dart';
import 'package:keptua/Controllers/Cubits/FavoriteColorsCubits/fetch_favorite_colors_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Controllers/fetch_favorite_colors_controller.dart';
import 'package:keptua/Views/MainScreenViews/main_screen.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/custom_error_indicator.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/custom_favorite_color_notifier.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/custom_loading_indicator.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/Data/utils.dart';
import 'package:keptua/Views/Utils/PageTransitions/scale_page_transition.dart';

class FavoriteColorsScreen extends StatefulWidget {
  final bool? theme;

  const FavoriteColorsScreen({super.key, required this.theme});

  @override
  State<FavoriteColorsScreen> createState() => _FavoriteColorsScreenState();
}

class _FavoriteColorsScreenState extends State<FavoriteColorsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchFavoriteColorsCubit>().favoriteColorsData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SharedPrefs.setInitPage(initPage: 'installed');
        Navigator.pushReplacement(
          context,
          ScalePageTransition.scalePageTransition(
            page: const MainScreen(),
            alignment: Alignment.centerRight,
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: widget.theme! ? AppColors.white : AppColors.themeBlack,
        appBar: AppBar(
          backgroundColor:
              widget.theme! ? AppColors.white : AppColors.themeBlack,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            Container(
              width: 1.sw,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        SharedPrefs.setInitPage(initPage: 'installed');
                        Navigator.pushReplacement(
                          context,
                          ScalePageTransition.scalePageTransition(
                            page: const MainScreen(),
                            alignment: Alignment.centerRight,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color:
                            widget.theme! ? AppColors.black : AppColors.white,
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Favorite Colors',
                      style: GoogleFonts.poppins(
                        color:
                            widget.theme! ? AppColors.black : AppColors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BlocListener<DeleteColorCubit, DeleteColorState>(
          listener: (context, deleteColorState) {
            if (deleteColorState is DeleteColorSuccess) {
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
          child:
              BlocConsumer<FetchFavoriteColorsCubit, FetchFavoriteColorsState>(
            listener: (context, fetchingFavColorsState) {
              if (fetchingFavColorsState is FetchFavoriteColorsEmpty) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, fetchingFavColorsState) {
              if (fetchingFavColorsState is FetchFavoriteColorsEmpty) {
                return CustomFavoriteColorsNotifier(theme: widget.theme!);
              } else if (fetchingFavColorsState is FetchFavoriteColorsLoading) {
                return CustomLoadingIndicator(theme: widget.theme!);
              } else if (fetchingFavColorsState is FetchFavoriteColorsError) {
                return CustomErrorIndicator(theme: widget.theme!);
              } else if (fetchingFavColorsState is FetchFavoriteColorsInitial) {
                return CustomLoadingIndicator(theme: widget.theme!);
              } else if (fetchingFavColorsState is FetchFavoriteColorsSuccess) {
                return Container(
                  height: 1.sh,
                  width: 1.sw,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.sp, vertical: 10.sp),
                  decoration: BoxDecoration(
                    color:
                        widget.theme! ? AppColors.white : AppColors.themeBlack,
                  ),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: FetchFavoriteColorsController
                        .userFavoriteColorsList.length,
                    separatorBuilder: (context, index) {
                      return Container(height: 10.sp);
                    },
                    itemBuilder: (context, ind) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onLongPress: () async {
                          context.read<DeleteColorCubit>().deleteFavoriteColor(
                                id: FetchFavoriteColorsController
                                    .userFavoriteColorsList[ind].id!,
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
                                  .userFavoriteColorsList[ind].id) {
                            SharedPrefs.setFavoriteColorIndex(
                                favoriteColorIndex:
                                    FetchFavoriteColorsController
                                        .userFavoriteColorsList[ind].id);

                            SharedPrefs.setDefaultColorIndex(
                                defaultColorIndex: 0);

                            if (SharedPrefs.getColor() == null) {
                              SharedPrefs.setColor(
                                  color: const Color(0xfffffffE).value);
                            } else {
                              SharedPrefs.setColor(
                                color: FetchFavoriteColorsController
                                    .userFavoriteColorsList[ind].colorValue!,
                              );
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

                            context
                                .read<FetchFavoriteColorsCubit>()
                                .favoriteColorsData();
                          } else {
                            SharedPrefs.setDefaultColorIndex(
                                defaultColorIndex: 0);
                          }
                        },
                        child: Container(
                          height: 80.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: Color(FetchFavoriteColorsController
                                .userFavoriteColorsList[ind].colorValue!),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: SharedPrefs.getFavoriteColorIndex() ==
                                  FetchFavoriteColorsController
                                      .userFavoriteColorsList[ind].id
                              ? Container(
                                  alignment: Alignment.centerRight,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.sp),
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
