import 'package:flutter/material.dart';
import 'package:keptua/Models/chip_data_model.dart';

class Chips {
  static final all = <ChipData>[
    ChipData(
      label: 'Mix',
      backgroundColor: Colors.red,
    ),
    ChipData(
      label: 'Smooth',
      backgroundColor: Colors.green,
    ),
    ChipData(
      label: 'Strob',
      backgroundColor: Colors.blue,
    ),
    ChipData(
      label: 'Fade',
      backgroundColor: Colors.orange,
    ),
    ChipData(
      label: 'Random',
      backgroundColor: Colors.pink,
    ),
  ];
}
