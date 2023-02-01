import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:keptua/Controllers/Repositories/add_favorite_color_repo.dart';
import 'package:keptua/Models/DataBase/color_model.dart';
import 'package:meta/meta.dart';

part 'add_favorite_color_state.dart';

class AddFavoriteColorCubit extends Cubit<AddFavoriteColorState> {
  AddFavoriteColorCubit() : super(AddFavoriteColorInitial());

  //adding favorite colors data method
  addFavoriteColor({required int? color}) async {
    try {
      print("colour"+color.toString());
      final forwardedColor = ColorModel(
        red: 0,
        green: 0,
        blue: 0,
        opacity: 0,
        shadow: 0,
        colorValue: color,
      );
      final response =
          await AddFavoriteColorRepo.addUserFavoriteColorsData(forwardedColor);

      if (response == 200) {
        emit(AddFavoriteColorSuccess());
      } else if (response == 10) {
        emit(AddFavoriteColorFailed());
      }
    } on Exception catch (e) {
      debugPrint('Add Favorite colors cubit exception: $e');
      emit(AddFavoriteColorError(
          'An error occurred while adding your favorite color'));
    }
  }
  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
