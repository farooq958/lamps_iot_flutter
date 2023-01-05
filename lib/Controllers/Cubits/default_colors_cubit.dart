import 'package:bloc/bloc.dart';

class DefaultColorsCubit extends Cubit<int?> {
  DefaultColorsCubit({required int? colorIndex}) : super(colorIndex);

  colorIndex({required int? colorIndex}) => emit(colorIndex);
}
