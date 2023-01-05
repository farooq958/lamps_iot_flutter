import 'package:flutter/cupertino.dart';
import 'package:keptua/Models/DataBase/color_model.dart';
import 'package:keptua/Models/DataBase/colors_db.dart';

class AddFavoriteColorRepo {
  //add user favorite colors
  static Future<int?> addUserFavoriteColorsData(ColorModel color) async {
    try {
      ColorModel? response =
          await ColorsDatabase.colorDatabaseInstance.create(color);
      debugPrint('add favorite color response $response');
      if (response != null) {
        return 200;
      } else if (response == null) {
        return 10;
      }
    } on Exception catch (e) {
      debugPrint('adding user favorite colors list exception: $e');
      return 0;
    }
  }
}
