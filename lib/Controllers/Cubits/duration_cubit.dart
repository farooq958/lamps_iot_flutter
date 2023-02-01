import 'package:bloc/bloc.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:meta/meta.dart';



class DurationCubit extends Cubit<Duration?> {
  DurationCubit() : super(Duration());

  setDuration()
  {
    Repository.audioPlayer.durationStream.listen((d) {
   Repository.duration=d!;
     emit(d);
      // context.read<DurationCubit>().setDuration(d!);
    });


    //return Repository.duration.toString().split(".")[0];
  }
}
