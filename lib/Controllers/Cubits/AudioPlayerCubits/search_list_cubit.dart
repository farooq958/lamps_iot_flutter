import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchListCubit extends Cubit<List> {
  SearchListCubit(List<SongModel>? initialState) : super([]);

  void songsList(List<SongModel>? songsList) {
    emit(songsList!);
  }
}
