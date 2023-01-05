import 'package:bloc/bloc.dart';

class AudioPlayerVisibilityCubit extends Cubit<bool> {
  AudioPlayerVisibilityCubit(bool initialState) : super(true);

  void visibility(bool visibility) {
    emit(visibility);
  }
}
