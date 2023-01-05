import 'package:bloc/bloc.dart';

class OpacityCubit extends Cubit<double?> {
  OpacityCubit(double initialValue) : super(0.0);

  setOpacity({required opacityValue}) {
    emit(opacityValue);
  }
}
