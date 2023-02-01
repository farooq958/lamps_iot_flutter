import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/first_song_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/item_wave_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/last_song_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/play_pause_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/player_bottom_sheet_visibility_cubit.dart';
import 'package:keptua/Controllers/Cubits/PositionCubit/position_cubit.dart';
import 'package:keptua/Controllers/Cubits/duration_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/AudioPlayer/audio_player_item.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';

class MusicList extends StatefulWidget {
  final bool theme;
  final bool? bottomSheetVisibilityState;
  final AsyncSnapshot? songItems;
  final bool? playPauseState;
  final List searchedList;
  //final progressStream ;
  const MusicList({
    super.key,
    required this.theme,
    required this.bottomSheetVisibilityState,
    required this.songItems,
    required this.playPauseState,
    required this.searchedList,
    //required this.progressStream,
  });

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
@override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //Repository.waveformController.dispose();
Repository.audioPlayer.dispose();
}

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: widget.bottomSheetVisibilityState!
          ? EdgeInsets.only(bottom: 300.sp)
          : EdgeInsets.only(bottom: 160.sp),
      color: widget.theme! ? AppColors.white : AppColors.themeBlack,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(25.sp),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.searchedList.length,
        separatorBuilder: (context, index) => Container(
          height: 16.sp,
          padding: EdgeInsets.zero,
          color: widget.theme! ? AppColors.white : AppColors.themeBlack,
        ),
        itemBuilder: (context, index) {
         // debugPrint('Song map title ${widget.searchedList[index].data}');
          return AudioPlayerItem(
            theme: widget.theme,
            title: widget.searchedList[index].title,
            artist: widget.searchedList[index].artist,
            filteredSong: widget.searchedList,
            ind: index,
            playPauseState: widget.playPauseState,
            songIndex: Repository.songId,
            //progressStream: widget.progressStream,
            onTap: () async {
              //assign the song index to global variable
              Repository.songId = index;
              context.read<ItemWaveCubit>().selectedSong(index);

              //make the play pause icon to play
              context.read<PlayPauseCubit>().playStatus(true);
              context.read<PositionCubit>().position();
              context.read<DurationCubit>().setDuration();
              //show model bottom controller once any song is selected
              context
                  .read<PlayerBottomSheetVisibilityCubit>()
                  .playerBottomSheetVisibility(true);
            //  print("uri--"+widget.searchedList[index].data);
              //Repository.preparePlayer(widget.searchedList[index].data);
           // Repository.init(widget.progressStream);
              //call the play song method
              Repository.playSong(songUri: widget.searchedList[index].uri);
            //  print("fromplay"+Repository.duration.inSeconds.toString());
            // setState(() {
            //   Repository.indexe=index;
            // });
              if (Repository.songId > 0) {
                context.read<FirstSongCubit>().isFirstSong(false);
              } else if (Repository.songId <= 0) {
                context.read<FirstSongCubit>().isFirstSong(true);
              }

              if (Repository.songId == widget.searchedList.length) {
                context.read<LastSongCubit>().isLastSong(true);
              } else if (Repository.songId < widget.searchedList.length) {
                context.read<LastSongCubit>().isLastSong(false);
              }
              Socket sc =await Socket.connect(Repository.wifiGateWayIP, 80);
           await   Future.delayed(const Duration(seconds: 2));
              print("gateway"+Repository.duration.toString());
              Repository.preparePlayer(widget.searchedList[index].data,Repository.duration.inSeconds,sc);

              //show audio waves
              // Repository.startAudioWaves(
              //   context: context,
              //   playerController: widget.playerController,
              //   startStopStatus: false,
              //   selectedSongPath: widget.searchedList[index].data,
              // );

              //context.read<AudioPlayerVisibilityCubit>().visibility(true);
              //////19-Dec-2022

            }, pitch: Repository.pitch,
          );
        },
      ),
    );
    
  }
// double pitchGet()
// {
//
//   Repository.audioPlayer.pitchStream.listen((event) {
//     setState(() => Repository.pitch = event);
//
//
//   });
//   return Repository.pitch;
//
// }
}
