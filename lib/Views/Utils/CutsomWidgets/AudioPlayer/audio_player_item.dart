import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/item_wave_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_images.dart';


class AudioPlayerItem extends StatelessWidget {
  final bool? theme;
  final String? title;
  final String? artist;
  final List filteredSong;
  final int? ind;
  final void Function()? onTap;
  final bool? playPauseState;
  final int? songIndex;
  //final progressStream;
  final double pitch;
  const AudioPlayerItem({
    super.key,
    required this.theme,
    required this.title,
    required this.artist,
    required this.filteredSong,
    required this.ind,
    required this.onTap,
    required this.playPauseState,
    required this.songIndex,
   // required this.progressStream,
    required this.pitch
  });

  @override
  Widget build(BuildContext context) {
  //  final progressStream2 = BehaviorSubject<WaveformProgress>();
//Repository.init(progressStream2);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 50.sp,
        width: 1.sw,
        color: Colors.white10,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50.sp,
                width: 50.sp,
                padding: EdgeInsets.all(4.sp),
                decoration: BoxDecoration(
                  color: AppColors.lightYellow,
                  borderRadius: BorderRadius.circular(6.sp),
                ),
                child: Image.asset(
                  AppImages.musicIcon,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: 50.sp,
                color: theme! ? AppColors.white : AppColors.themeBlack,
                alignment: Alignment.centerLeft,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 20.sp),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                    Container(
                      height: 1.sp,
                      padding: EdgeInsets.zero,
                      color: theme! ? AppColors.white : AppColors.themeBlack,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          artist == '<unknown>' ? 'Unknown Artist' : '$artist',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 10.sp,
                            color: AppColors.greyTwo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: BlocBuilder<ItemWaveCubit, int>(
                builder: (context, itemWaveState) {
                  return !playPauseState!
                      ? Container(
                    color: theme!
                        ? AppColors.white
                        : AppColors.themeBlack,
                  )
                      : ind != itemWaveState
                          ?  Container(
                    color: theme!
                        ? AppColors.white
                        : AppColors.themeBlack,
                  )
                          : Container(
                              alignment: Alignment.center,
                              color:theme!
                                  ? AppColors.white
                                  : AppColors.themeBlack,

child: Text(pitch.toString()),
// child: Visualizer(
//   builder: (BuildContext context, List<int> wave) {
//     return CustomPaint(
//       painter: LineVisualizer(
//         waveData: Repository.wavedata,
//         height: MediaQuery.of(context).size.height,
//         width : MediaQuery.of(context).size.width,
//         color: Colors.blueAccent,
//       ),
//       child: Container(),
//     );
//   },
//   id: Repository.audioPlayer.androidAudioSessionId,
// ),
// child: StreamBuilder<WaveformProgress>(
//   stream: progressStream2,
//   builder: (context, snapshot) {
//     print(snapshot.error);
//     if (snapshot.hasError) {
//       return Center(
//         child: Text(
//           'Error: ${snapshot.error}',
//           style: Theme.of(context).textTheme.headline6,
//           textAlign: TextAlign.center,
//         ),
//       );
//     }
//     final progress = snapshot.data?.progress ?? 0.0;
//     final waveform = snapshot.data?.waveform;
//     if (waveform == null) {
//       return Center(
//         child: Text(
//           '${(100 * progress).toInt()}%',
//           style: Theme.of(context).textTheme.headline6,
//         ),
//       );
//     }
//     return AudioWaveformWidget(
//       waveform: waveform,
//       start: Duration.zero,
//       duration: waveform.duration,
//     );
//   },
// ),
                              // child: PolygonWaveform(samples: [], height: 50.sp, width: 30.sp,),

                              //   child: AudioFileWaveforms(
                              //   size: Size(70.sp, 50.sp),
                              //   playerController:
                              //       Repository.playerController,
                              //
                              //     density: 1.5,
                              //     playerWaveStyle: const PlayerWaveStyle(
                              //       scaleFactor: 0.8,
                              //       fixedWaveColor: Colors.white30,
                              //       liveWaveColor: Colors.white,
                              //       waveCap: StrokeCap.butt,
                              //     ),
                              // ),
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
