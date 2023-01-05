import 'package:flutter/cupertino.dart';
import 'package:keptua/Controllers/fetch_favorite_colors_controller.dart';
import 'package:keptua/Models/DataBase/colors_db.dart';

class FetchFavoriteColorsRepo {
  //fetch favorite user favorite colors
  static Future<int?> userFavoriteColorsData() async {
    try {
      FetchFavoriteColorsController.userFavoriteColorsList =
          await ColorsDatabase.colorDatabaseInstance.readAllColors();
      if (FetchFavoriteColorsController.userFavoriteColorsList.isNotEmpty) {
        return 200;
      } else if (FetchFavoriteColorsController.userFavoriteColorsList.isEmpty) {
        return 10;
      }
    } on Exception catch (e) {
      debugPrint('fetching favorite colors list exception: $e');
      return 0;
    }
  }
}
