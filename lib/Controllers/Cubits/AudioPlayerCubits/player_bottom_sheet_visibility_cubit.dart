import 'package:bloc/bloc.dart';

class PlayerBottomSheetVisibilityCubit extends Cubit<bool> {
  PlayerBottomSheetVisibilityCubit(bool initialState) : super(false);

  void playerBottomSheetVisibility(bool playerBottomSheetVisibility) {
    emit(playerBottomSheetVisibility);
  }
}
