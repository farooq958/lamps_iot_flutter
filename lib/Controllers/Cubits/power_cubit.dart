import 'package:bloc/bloc.dart';

class PowerCubit extends Cubit<bool> {
  PowerCubit(bool initialState) : super(false);

  void power(bool power) {
    emit(power);
  }
}
