import 'package:bloc/bloc.dart';

class ItemWaveCubit extends Cubit<int> {
  ItemWaveCubit({required songItemIndex}) : super(0);

  void selectedSong(int index) {
    emit(index);
  }
}
