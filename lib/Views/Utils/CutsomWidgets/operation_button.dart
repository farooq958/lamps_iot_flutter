import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/waves_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Models/action_chip_model.dart';
import 'package:keptua/Models/chip_data_model.dart';
import 'package:keptua/Models/choice_chip_model.dart';
import 'package:keptua/Models/filter_chip_model.dart';
import 'package:keptua/Models/input_chip_model.dart';
import 'package:keptua/Views/Utils/Data/action_chips.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/Data/chips.dart';
import 'package:keptua/Views/Utils/Data/choice_chips.dart';
import 'package:keptua/Views/Utils/Data/filter_chips.dart';
import 'package:keptua/Views/Utils/Data/input_chips.dart';
import 'package:keptua/Views/Utils/Data/utils.dart';

class OperationButtons extends StatefulWidget {
  final bool? power;
  final bool? theme;

  const OperationButtons({
    super.key,
    required this.power,
    required this.theme,
  });

  @override
  State<OperationButtons> createState() => _OperationButtonsState();
}

class _OperationButtonsState extends State<OperationButtons> {
  int index = 4;

  final double spacing = 8.sp;

  List<ChipData> chips = Chips.all;

  List<InputChipData> inputChips = InputChips.all;

  List<ActionChipData> actionChips = ActionChips.all;

  List<FilterChipData> filterChips = FilterChips.all;

  List<ChoiceChipData> choiceChips = ChoiceChips.all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18.sp,
        vertical: 5.sp,
      ),
      child: Wrap(
        runSpacing: 20.sp,
        spacing: 10.sp,
        alignment: WrapAlignment.center,
        children: choiceChips
            .map((choiceChip) => ChoiceChip(
                  elevation: choiceChip.isSelected ? 30.sp : 0.sp,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.symmetric(
                    vertical: 12.sp,
                    horizontal: 20.sp,
                  ),
                  label: Container(
                    height: 30.sp,
                    width: 80.sp,
                    alignment: Alignment.center,
                    child: Text(choiceChip.label),
                  ),
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: choiceChip.isSelected && widget.theme! == false
                        ? AppColors.yellow
                        : !choiceChip.isSelected && widget.theme! == true
                            ? AppColors.yellow
                            : AppColors.white,
                    fontStyle: FontStyle.normal,
                    fontSize: 18.sp,
                  ),
                  side: BorderSide(
                    color: choiceChip.isSelected && widget.theme! == false
                        ? AppColors.yellow
                        : !choiceChip.isSelected && widget.theme! == true
                            ? AppColors.yellow
                            : AppColors.yellow,
                    width: 2.sp,
                  ),
                  selected: choiceChip.isSelected,
                  selectedColor:
                      widget.theme! ? AppColors.yellow : AppColors.themeBlack,
                  backgroundColor:
                      widget.theme! ? AppColors.white : AppColors.themeBlack,
                  onSelected: (isSelected) {
                    Utils.showSnackBar(
                      theme: widget.theme!,
                      context: context,
                      message: 'Please wait...',
                    );

                    Timer(const Duration(seconds: 2), () {
                      setState(() {
                        choiceChips = choiceChips.map((otherChip) {
                          final newChip = otherChip.copy(isSelected: false);
                          if (choiceChip == newChip) {
                            SharedPrefs.setFavoriteColorIndex(
                                favoriteColorIndex: 0);
                            SharedPrefs.setDefaultColorIndex(
                                defaultColorIndex: 0);

                            // //backend operation
                            Repository.operation(
                              context: context,
                              gatewayIP: Repository.wifiGateWayIP,
                              operation: choiceChip.label,
                            );

                            // if (choiceChip.label == 'Base') {
                            //   context.read<WavesCubit>().waves(true);
                            // }

                            return newChip.copy(
                                isSelected: isSelected,
                                label: choiceChip.label,
                                textColor: choiceChip.textColor,
                                selectedColor: choiceChip.selectedColor);
                          } else {
                            if (choiceChip.label == 'Base') {
                              context.read<WavesCubit>().waves(false);
                            }
                            return newChip;
                          }
                        }).toList();
                      });
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget buildChips() => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: chips
            .map((chip) => Chip(
                  labelPadding: EdgeInsets.all(4.sp),
                  avatar: CircleAvatar(
                    child: Text('AZ'),
                    backgroundColor: Colors.white,
                  ),
                  label: Text(chip.label),
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  backgroundColor: chip.backgroundColor,
                ))
            .toList(),
      );

  Widget buildActionChip({required BuildContext context}) => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: actionChips
            .map((actionChip) => ActionChip(
                  avatar: Icon(
                    actionChip.icon,
                    color: actionChip.iconColor,
                  ),
                  backgroundColor: Colors.grey[200],
                  label: Text(actionChip.label),
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  onPressed: () => Utils.showSnackBar(
                    message: 'Do action "${actionChip.label}"',
                    context: context,
                    theme: widget.theme!,
                  ),
                ))
            .toList(),
      );

  Widget buildInputChips({required BuildContext context}) => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: inputChips
            .map((inputChip) => InputChip(
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(inputChip.urlAvatar),
                  ),
                  label: Text(inputChip.label),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  onPressed: () => Utils.showSnackBar(
                    theme: widget.theme!,
                    context: context,
                    message: 'Interacted with "${inputChip.label}"...',
                  ),
                  onDeleted: () => setState(() => inputChips.remove(inputChip)),
                ))
            .toList(),
      );

  Widget buildFilterChips() => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: filterChips
            .map((filterChip) => FilterChip(
                  label: Text(filterChip.label),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: filterChip.color,
                  ),
                  backgroundColor: filterChip.color.withOpacity(0.1),
                  onSelected: (isSelected) => setState(() {
                    filterChips = filterChips.map((otherChip) {
                      return filterChip == otherChip
                          ? otherChip.copy(
                              isSelected: isSelected,
                              label: filterChip.label,
                              color: filterChip.color)
                          : otherChip;
                    }).toList();
                  }),
                  selected: filterChip.isSelected,
                  checkmarkColor: filterChip.color,
                  selectedColor: filterChip.color.withOpacity(0.25),
                ))
            .toList(),
      );
}
