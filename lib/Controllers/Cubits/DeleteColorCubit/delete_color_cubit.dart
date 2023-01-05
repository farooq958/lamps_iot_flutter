import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:keptua/Controllers/Repositories/delete_color_repo.dart';
import 'package:meta/meta.dart';

part 'delete_color_state.dart';

class DeleteColorCubit extends Cubit<DeleteColorState> {
  DeleteColorCubit() : super(DeleteColorInitial());

  //deleting favorite colors data method
  deleteFavoriteColor({required int id}) async {
    try {
      // final forwardedColorId = ColorModel(
      //   red: 0,
      //   green: 0,
      //   blue: 0,
      //   opacity: 0,
      //   shadow: 0,
      //   colorValue: color,
      // );
      final response = await DeleteColorRepo.deleteUserFavoriteColorsData(id);

      if (response == 200) {
        emit(DeleteColorSuccess());
      } else if (response == 10) {
        emit(DeleteColorFailed());
      }
    } on Exception catch (e) {
      debugPrint('Delete Favorite colors cubit exception: $e');
      emit(DeleteColorError('An error occurred while deleting color'));
    }
  }
}
