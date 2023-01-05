import 'package:bloc/bloc.dart';

class FavoriteCubit extends Cubit<bool> {
  FavoriteCubit(bool initialState) : super(false);

  void favorite(bool colorState) {
    emit(colorState);
  }
}
