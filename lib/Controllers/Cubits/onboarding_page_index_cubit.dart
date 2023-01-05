import 'package:bloc/bloc.dart';

class OnboardingPageIndexCubit extends Cubit<int?> {
  OnboardingPageIndexCubit(int initialState) : super(0);

  setIndex({required index}) {
    emit(index);
  }
}
