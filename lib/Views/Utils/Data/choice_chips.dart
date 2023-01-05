import 'package:keptua/Models/choice_chip_model.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: AppStrings.mix,
      isSelected: false,
      selectedColor: AppColors.yellow,
      textColor: AppColors.white,
    ),
    ChoiceChipData(
      label: AppStrings.smooth,
      isSelected: false,
      selectedColor: AppColors.yellow,
      textColor: AppColors.white,
    ),
    ChoiceChipData(
      label: AppStrings.strob,
      isSelected: false,
      selectedColor: AppColors.yellow,
      textColor: AppColors.white,
    ),
    ChoiceChipData(
      label: AppStrings.fade,
      isSelected: false,
      selectedColor: AppColors.yellow,
      textColor: AppColors.white,
    ),
    ChoiceChipData(
      label: AppStrings.random,
      isSelected: false,
      selectedColor: AppColors.yellow,
      textColor: AppColors.white,
    ),
    // ChoiceChipData(
    //   label: AppStrings.base,
    //   isSelected: false,
    //   selectedColor: AppColors.yellow,
    //   textColor: AppColors.white,
    // ),
  ];
}
