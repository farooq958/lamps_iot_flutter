import 'package:bloc/bloc.dart';

class FirstSongCubit extends Cubit<bool> {
  FirstSongCubit(bool initialStat) : super(false);

  void isFirstSong(bool firstSong) {
    emit(firstSong);
  }
}
