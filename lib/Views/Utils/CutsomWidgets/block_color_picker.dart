import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';

class BlockColorPicker extends StatefulWidget {
  const BlockColorPicker({Key? key}) : super(key: key);

  @override
  State<BlockColorPicker> createState() => _BlockColorPickerState();
}

class _BlockColorPickerState extends State<BlockColorPicker> {
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      color: AppColors.white,
      padding: EdgeInsets.only(left: 10.sp),
      // child: BlockPicker(
      //   pickerColor: color,
      //   onColorChanged: (choosenColor) {
      //     if (choosenColor == const Color(0xffFECE38)) {
      //       debugPrint('Color Choose from Bar red===> 254');
      //       debugPrint('Color Choose from Bar green===> 206');
      //       debugPrint('Color Choose from Bar blue===> 56');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '254',
      //         green: '206',
      //         blue: '56',
      //       );
      //     } else if (choosenColor == const Color(0xff8ffe38)) {
      //       debugPrint('Color Choose from Bar red===> 143');
      //       debugPrint('Color Choose from Bar green===> 254');
      //       debugPrint('Color Choose from Bar blue===> 56');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '143',
      //         green: '254',
      //         blue: '56',
      //       );
      //     } else if (choosenColor == const Color(0xff38CEFE)) {
      //       debugPrint('Color Choose from Bar red===> 56');
      //       debugPrint('Color Choose from Bar green===> 206');
      //       debugPrint('Color Choose from Bar blue===> 254');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '56',
      //         green: '206',
      //         blue: '254',
      //       );
      //     } else if (choosenColor == const Color(0xffBF38FE)) {
      //       debugPrint('Color Choose from Bar red===> 191');
      //       debugPrint('Color Choose from Bar green===> 56');
      //       debugPrint('Color Choose from Bar blue===> 254');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '191',
      //         green: '56',
      //         blue: '254',
      //       );
      //     } else if (choosenColor == const Color(0xffFE385C)) {
      //       debugPrint('Color Choose from Bar red===> 254');
      //       debugPrint('Color Choose from Bar green===> 56');
      //       debugPrint('Color Choose from Bar blue===> 92');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '254',
      //         green: '56',
      //         blue: '92',
      //       );
      //     } else if (choosenColor == const Color(0xff272586)) {
      //       debugPrint('Color Choose from Bar red===> 39');
      //       debugPrint('Color Choose from Bar green===> 37');
      //       debugPrint('Color Choose from Bar blue===> 134');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '39',
      //         green: '37',
      //         blue: '134',
      //       );
      //     } else if (choosenColor == const Color(0xffFE7338)) {
      //       debugPrint('Color Choose from Bar red===> 254');
      //       debugPrint('Color Choose from Bar green===> 115');
      //       debugPrint('Color Choose from Bar blue===> 56');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '254',
      //         green: '115',
      //         blue: '56',
      //       );
      //     } else if (choosenColor == const Color(0xffFF508F)) {
      //       debugPrint('Color Choose from Bar red===> 255');
      //       debugPrint('Color Choose from Bar green===> 80');
      //       debugPrint('Color Choose from Bar blue===> 143');
      //       debugPrint('Color Choose from Bar opacity===> 1');
      //       Repository.setColor(
      //         context: context,
      //         gatewayIP: Repository.wifiGateWayIP,
      //         red: '255',
      //         green: '80',
      //         blue: '143',
      //       );
      //     }
      //   },
      //   availableColors: const [
      //     Color(0xffFECE38),
      //     Color(0xff8FFE38),
      //     Color(0xff38CEFE),
      //     Color(0xffBF38FE),
      //     Color(0xffFE385C),
      //     Color(0xff272586),
      //     Color(0xffFE7338),
      //     Color(0xffFF508F),
      //   ],
      // ),
    );
  }
}
