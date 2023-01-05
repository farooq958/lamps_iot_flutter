import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Controllers/Cubits/AddFavoriteColorCubit/add_favorite_color_cubit.dart';
import 'package:keptua/Controllers/Cubits/FavoriteColorsCubits/fetch_favorite_colors_cubit.dart';
import 'package:keptua/Controllers/Cubits/favorite_cubit.dart';
import 'package:keptua/Controllers/Cubits/waves_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_images.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/Data/utils.dart';

class CircleColorPicker extends StatefulWidget {
  // final bool? power;
  final bool? theme;

  const CircleColorPicker({
    super.key,
    // required this.power,
    required this.theme,
  });

  @override
  State<CircleColorPicker> createState() => _CircleColorPickerState();
}

class _CircleColorPickerState extends State<CircleColorPicker> {
  Color color = Colors.white; //last change
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh / 2.25,
      width: 1.sw,
      color: widget.theme! ? AppColors.white : AppColors.themeBlack,
      padding: EdgeInsets.symmetric(
        horizontal: 32.sp,
        vertical: 5.sp,
      ),
      child: Stack(
        children: [
          //waves
          Positioned(
            top: -147.sp,
            left: 2.sp,
            right: 0,
            child: BlocBuilder<WavesCubit, bool>(
              builder: (context, wavesState) {
                return wavesState
                    ? Image.asset(
                        AppImages.gif,
                        height: 615.sp,
                        width: 615.sp,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox();
              },
            ),
          ),

          //favorite icon
          Positioned(
            bottom: 80.sp,
            right: 15.sp,
            child: BlocBuilder<FavoriteCubit, bool>(
              builder: (context, favoriteState) {
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (favoriteState == true) {
                      context.read<FavoriteCubit>().favorite(false);
                    } else if (favoriteState == false) {
                      if (SharedPrefs.getColor() == 4294967294 ||
                          SharedPrefs.getColor() == 4278190094 ||
                          SharedPrefs.getColor() == 4294901760 ||
                          SharedPrefs.getColor() == 4278255360 ||
                          SharedPrefs.getColor() == 4278190335) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            Utils.showCustomSnackBar(
                              context: context,
                              message: 'Already marked as favorite',
                              theme: widget.theme!,
                            ),
                          );
                      } else {
                        context.read<FavoriteCubit>().favorite(true);
                        context
                            .read<AddFavoriteColorCubit>()
                            .addFavoriteColor(color: SharedPrefs.getColor());
                        await context
                            .read<FetchFavoriteColorsCubit>()
                            .favoriteColorsData();
                      }
                    }
                  },
                  child: Icon(
                    favoriteState ||
                            SharedPrefs.getColor() == 4294967294 ||
                            SharedPrefs.getColor() == 4278190094 ||
                            SharedPrefs.getColor() == 4294901760 ||
                            SharedPrefs.getColor() == 4278255360 ||
                            SharedPrefs.getColor() == 4278190335
                        ? Icons.favorite
                        : Icons.favorite_outline_sharp,
                    //favorite //favorite_outline_sharp
                    color: AppColors.red,
                    size: 35.sp,
                  ),
                );
              },
            ),
          ),

          //color picker
          Positioned(
            top: 0.sp,
            left: 0.sp,
            right: 0.sp,
            // child: const SizedBox(),
            child: ColorPicker(
              pickerColor: SharedPrefs.getColor() == null
                  ? const Color(0xfffffffE)
                  : Color(SharedPrefs.getColor()!),
              paletteType: PaletteType.hueWheel,
              enableAlpha: false,
              labelTypes: const [],
              onColorChanged: (pickedColor) async {
                //do not remove this line of code it is important
                if (SharedPrefs.getColor() == null) {
                  SharedPrefs.setColor(color: const Color(0xfffffffE).value);
                } else {
                  SharedPrefs.setColor(color: pickedColor.value);
                }

                //favorite color status
                context.read<FavoriteCubit>().favorite(false);

                //set the default color picker to uncheck or zero index
                SharedPrefs.setDefaultColorIndex(defaultColorIndex: 0);

                // //backend operation
                String? redColorValue =
                    Color(SharedPrefs.getColor()!).red.toString();
                String? blueColorValue =
                    Color(SharedPrefs.getColor()!).blue.toString();
                String? greenColorValue =
                    Color(SharedPrefs.getColor()!).green.toString();
                // String? opacity =
                //     Color(SharedPrefs.getColor()!).alpha.toString();
                // debugPrint('red =>$redColorValue');
                // debugPrint('green =>$greenColorValue');
                // debugPrint('blue =>$blueColorValue');
                // debugPrint('opacity =>$opacity');
                Repository.setColor(
                  context: context,
                  gatewayIP: Repository.wifiGateWayIP,
                  red: redColorValue,
                  green: greenColorValue,
                  blue: blueColorValue,
                  // opacity: opacity,
                );
                // SharedPrefs.setColor(color: SharedPrefs.getOpacity()!);
              },
              displayThumbColor: true,
              hexInputBar: false,
              portraitOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
