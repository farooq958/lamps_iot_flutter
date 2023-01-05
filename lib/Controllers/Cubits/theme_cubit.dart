import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit(bool initialState) : super(true);

  void selectedTheme(bool theme) {
    emit(theme);
  }
}
