import 'package:bloc/bloc.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:meta/meta.dart';



class PositionCubit extends Cubit<Duration?> {
  PositionCubit() : super(Duration());

   position() {
    Repository.audioPlayer.positionStream.listen((p) {


     Repository.position=p;
     emit(p);


//context.read<PositionCubit>().setPosition(p);
      // Repository.preparePlayer(widget.searchedList[Repository.indexe].data);

    });
   // return Repository.position.toString().split(".")[0];
  }
}
