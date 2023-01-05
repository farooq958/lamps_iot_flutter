import 'package:bloc/bloc.dart';

class LastSongCubit extends Cubit<bool> {
  LastSongCubit(bool initialStat) : super(false);

  void isLastSong(bool lastSong) {
    emit(lastSong);
  }
}
