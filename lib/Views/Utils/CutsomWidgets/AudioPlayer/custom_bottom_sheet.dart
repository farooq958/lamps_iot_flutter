import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/first_song_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/item_wave_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/last_song_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/play_pause_cubit.dart';
import 'package:keptua/Controllers/Cubits/PositionCubit/position_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_icons.dart';

import '../../../../Controllers/Cubits/duration_cubit.dart';

class CustomAudioPlayerBottomSheet extends StatefulWidget {
  final bool? theme;
  final AsyncSnapshot? songItems;
  final bool? playPauseState;
  final List searchedList;

  const CustomAudioPlayerBottomSheet({
    super.key,
    required this.theme,
    required this.songItems,
    required this.playPauseState,
    required this.searchedList,
  });

  @override
  State<CustomAudioPlayerBottomSheet> createState() =>
      _CustomAudioPlayerBottomSheetState();
}

class _CustomAudioPlayerBottomSheetState
    extends State<CustomAudioPlayerBottomSheet> {

  @override
  void initState() {
    // context.read<PositionCubit>().position();
    // context.read<DurationCubit>().setDuration();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145.sp,
      width: 1.sw,
      decoration: BoxDecoration(
        color: widget.theme! ? AppColors.white : AppColors.themeBlack,
        borderRadius: BorderRadius.only(
          topLeft:
          widget.theme! ? Radius.circular(15.sp) : Radius.circular(8.sp),
          topRight:
          widget.theme! ? Radius.circular(15.sp) : Radius.circular(8.sp),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.theme! ? AppColors.grey : AppColors.white,
            offset: Offset(0.sp, -1.sp),
            spreadRadius: 0.sp,
            blurRadius: 5.sp,
          ),
        ],
      ),
      child: BlocConsumer<DurationCubit, Duration?>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, durationValue) {
    return BlocConsumer<PositionCubit, Duration?>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, positionValue) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: 15.sp,
              left: 15.sp,
              right: 15.sp,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              //Audio Player slider


              Container(
                height: 30.sp,
                width: 1.sw,
                color: widget.theme! ? AppColors.white : AppColors
                    .themeBlack,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 1.5.sp,
                    thumbColor: AppColors.yellow,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 14.sp,
                      elevation: 0,
                      pressedElevation: 0,
                    ),
                  ),
                  child: Slider(
                    min: const Duration(microseconds: 0).inSeconds
                        .toDouble(),
                    value: positionValue!.inSeconds.toDouble(),
                    max: durationValue!.inSeconds.toDouble(),
                    onChanged: (value) {
                      changeToSeconds(value.toInt());
                      value = value;
                    },
                    inactiveColor: AppColors.yellow,
                    activeColor: AppColors.yellow,
                  ),
                ),
              )


              ,


              //song timings (start & remain)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          positionValue.toString().split(".")[0],
                          // position(),
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.normal,
                            fontSize: 10.sp,
                            color: widget.theme!
                                ? AppColors.greyThree
                                : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                         durationValue.toString().split(".")[0],
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.normal,
                            fontSize: 10.sp,
                            color: widget.theme!
                                ? AppColors.greyThree
                                : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 7.sp,
                color: widget.theme! ? AppColors.white : AppColors.themeBlack,
              ),

              //back, forward, play and pause buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.sp),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: BlocBuilder<FirstSongCubit, bool>(
                        builder: (context, firstSongState) {
                          return InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: firstSongState
                                ? () {}
                                : () {
                              debugPrint('previous');

                              Repository.songId--;
                              context
                                  .read<ItemWaveCubit>()
                                  .selectedSong(Repository.songId);

                              if (Repository.songId <= 0) {
                                Repository.songId = 0;
                                context
                                    .read<PlayPauseCubit>()
                                    .playStatus(true);
                                context
                                    .read<LastSongCubit>()
                                    .isLastSong(false);
                                context
                                    .read<FirstSongCubit>()
                                    .isFirstSong(true);

                                Repository.playSong(
                                  songUri: widget.songItems!.data![0].uri,
                                );
                              } else {
                                context
                                    .read<PlayPauseCubit>()
                                    .playStatus(true);
                                context
                                    .read<LastSongCubit>()
                                    .isLastSong(false);
                                context
                                    .read<FirstSongCubit>()
                                    .isFirstSong(false);

                                Repository.playSong(
                                  songUri: widget.songItems!
                                      .data![Repository.songId].uri,
                                );
                              }

                              // Repository.songId = Repository.songId++;
                            },
                            child: Icon(
                              AppIcons.play_back_arrow,
                              color: firstSongState
                                  ? AppColors.greyTwo
                                  : AppColors.yellow,
                              size: 22.sp,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: BlocBuilder<PlayPauseCubit, bool>(
                        builder: (context, playPauseState) {
                          return InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (playPauseState == true) {
                                Repository.audioPlayer.pause();
                                context.read<PlayPauseCubit>().playStatus(
                                    false);
                                //Repository.waveformController.stop();
                              } else if (playPauseState == false) {
                                Repository.audioPlayer.play();
                                context.read<PlayPauseCubit>().playStatus(true);
                                //Repository.waveformController.record();
                              }
                            },
                            child: Container(
                              height: 59.sp,
                              width: 59.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1.sp,
                                  color: AppColors.yellow,
                                ),
                              ),
                              child: Icon(
                                playPauseState ? Icons.pause : Icons.play_arrow,
                                color: AppColors.yellow,
                                size: 35.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: BlocBuilder<LastSongCubit, bool>(
                        builder: (context, lastSongState) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: lastSongState
                                ? () {}
                                : () {
                              debugPrint('next');

                              debugPrint(
                                  'before increment ${Repository.songId}');
                              Repository.songId++;
                              debugPrint(
                                  'after increment id ${Repository.songId}');
                              debugPrint(
                                  'search list length ${widget.searchedList
                                      .length}');
                              debugPrint(
                                  'normal list length ${widget.songItems!
                                      .data
                                      .toString()
                                      .length}');

                              context
                                  .read<ItemWaveCubit>()
                                  .selectedSong(Repository.songId);

                              if (Repository.songId >=
                                  widget.searchedList.length) {
                                Repository.songId =
                                    widget.searchedList.length;
                                debugPrint('if song id ${Repository.songId}');
                                context
                                    .read<PlayPauseCubit>()
                                    .playStatus(true);
                                context
                                    .read<LastSongCubit>()
                                    .isLastSong(true);
                                context
                                    .read<FirstSongCubit>()
                                    .isFirstSong(false);

                                Repository.playSong(
                                  songUri: widget.songItems!
                                      .data![Repository.songId].uri,
                                );
                              } else {
                                debugPrint(
                                    'else song id ${Repository.songId}');
                                context
                                    .read<PlayPauseCubit>()
                                    .playStatus(true);
                                context
                                    .read<LastSongCubit>()
                                    .isLastSong(false);
                                context
                                    .read<FirstSongCubit>()
                                    .isFirstSong(false);

                                Repository.playSong(
                                  songUri: widget.songItems!
                                      .data![Repository.songId].uri,
                                );
                              }
                              // Repository.songId = Repository.songId++;
                            },
                            child: Icon(
                              AppIcons.play_forward_arrow,
                              color: lastSongState
                                  ? AppColors.greyTwo
                                  : AppColors.yellow,
                              size: 22.sp,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
  },
),
    );
  }

//   String position() {
//     Repository.audioPlayer.positionStream.listen((p) {
//       if(!mounted)
//       {return;}
//       setState(() => Repository.position = p);
// //context.read<PositionCubit>().setPosition(p);
//       // Repository.preparePlayer(widget.searchedList[Repository.indexe].data);
//
//     });
//     return Repository.position.toString().split(".")[0];
//   }

  // String duration() {
  //   Repository.audioPlayer.durationStream.listen((d) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() => Repository.duration = d!);
  //     // context.read<DurationCubit>().setDuration(d!);
  //   });
  //
  //
  //   return Repository.duration.toString().split(".")[0];
  // }

  String pitch() {
    // Repository.audioPlayer.pitchStream.listen((d) {
    //   if(!mounted)
    //   {return;}
    //  // setState(() => Repository.pitch = d);
    //
    // });
    return Repository.pitch.toString().split(".")[0];
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Repository.audioPlayer.seek(duration);
  }
}
