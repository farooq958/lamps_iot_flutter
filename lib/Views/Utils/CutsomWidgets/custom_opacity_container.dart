import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/opacity_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';

class CustomOpacityContainer extends StatelessWidget {
  final bool? theme;

  const CustomOpacityContainer({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.sp,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
      color: theme! ? AppColors.white : AppColors.themeBlack,
      child: BlocBuilder<OpacityCubit, double?>(
        builder: (context, opacityValueState) {
          if (SharedPrefs.getOpacity() == null) {
            SharedPrefs.setOpacity(opacity: 0);
          }
          return ListView(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 30.sp,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 15.5.sp,
                    elevation: 0,
                    pressedElevation: 0,
                  ),
                ),
                child: Slider(
                  value: SharedPrefs.getOpacity()!.toDouble(),
                  min: 0.0,
                  max: 255.0,
                  activeColor: Color(SharedPrefs.getColor()!),
                  inactiveColor:
                      Color(SharedPrefs.getColor()!).withOpacity(0.5),
                  // thumbColor: Color(SharedPrefs.getColor()!).withOpacity(0.1),
                  thumbColor: Colors.white,
                  onChanged: (newValue) {
                    SharedPrefs.setOpacity(opacity: newValue.toInt());
                    Repository.setOpacity(
                      context: context,
                      gatewayIP: Repository.wifiGateWayIP,
                      opacity: SharedPrefs.getOpacity().toString(),
                    );
                    context
                        .read<OpacityCubit>()
                        .setOpacity(opacityValue: newValue);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.sp),
                child: Text(
                  'Value: ${SharedPrefs.getOpacity()}',
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: theme! ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
