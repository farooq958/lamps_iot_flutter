import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:keptua/Controllers/Repositories/fetch_favorite_colors_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_favorite_colors_state.dart';

class FetchFavoriteColorsCubit extends Cubit<FetchFavoriteColorsState> {
  FetchFavoriteColorsCubit() : super(FetchFavoriteColorsInitial());

  //fetching favorite colors data method
  favoriteColorsData() async {
    try {
      final response = await FetchFavoriteColorsRepo.userFavoriteColorsData();

      if (response == 200) {
        emit(FetchFavoriteColorsSuccess());
      } else if (response == 10) {
        emit(FetchFavoriteColorsEmpty());
      }
    } on Exception catch (e) {
      debugPrint('User Favorite colors cubit exception: $e');
      emit(FetchFavoriteColorsError(
          'An error occurred while fetching your favorite colors'));
    }
  }
}
