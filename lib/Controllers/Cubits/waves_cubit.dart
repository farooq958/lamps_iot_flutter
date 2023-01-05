import 'package:bloc/bloc.dart';

class WavesCubit extends Cubit<bool> {
  WavesCubit(bool initialState) : super(false);

  void waves(bool waves) {
    emit(waves);
  }
}
