import 'package:flutter/cupertino.dart';
import 'package:keptua/Models/DataBase/colors_db.dart';

class DeleteColorRepo {
  //delete user favorite colors
  static Future<int?> deleteUserFavoriteColorsData(int id) async {
    try {
      int? response = await ColorsDatabase.colorDatabaseInstance.delete(id);
      debugPrint('delete favorite color response $response');
      if (response != null) {
        return 200;
      } else if (response == null) {
        return 10;
      }
    } on Exception catch (e) {
      debugPrint('deleting user favorite colors list exception: $e');
      return 0;
    }
  }
}
