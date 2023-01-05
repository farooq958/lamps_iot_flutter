import 'package:bloc/bloc.dart';

class PlayPauseCubit extends Cubit<bool> {
  PlayPauseCubit(bool initialState) : super(false);

  void playStatus(bool playStatus) {
    emit(playStatus);
  }
}
