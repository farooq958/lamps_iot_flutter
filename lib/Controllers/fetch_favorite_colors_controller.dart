import 'package:keptua/Models/DataBase/color_model.dart';

class FetchFavoriteColorsController {
  static ColorModel favoriteColors = ColorModel(
    red: 0,
    green: 0,
    blue: 0,
    opacity: 0,
    shadow: 0,
    colorValue: 0,
  );

  static List<ColorModel> userFavoriteColorsList = [];
}
