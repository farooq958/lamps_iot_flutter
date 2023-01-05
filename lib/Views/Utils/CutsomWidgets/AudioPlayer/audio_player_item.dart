import 'package:audio_waveforms/audio_waveforms.dart';
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
  });

  @override
  Widget build(BuildContext context) {
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
                      ? const SizedBox()
                      : ind != itemWaveState
                          ? const SizedBox()
                          : Container(
                              alignment: Alignment.center,
                              color: theme!
                                  ? AppColors.white
                                  : AppColors.themeBlack,
                              child: AudioWaveforms(
                                size: Size(70.sp, 50.sp),
                                recorderController:
                                    Repository.waveformController,
                                enableGesture: false,
                                waveStyle: WaveStyle(
                                  showDurationLabel: false,
                                  spacing: 8.sp,
                                  showBottom: false,
                                  extendWaveform: true,
                                  showMiddleLine: false,
                                  waveThickness: 5.sp,
                                  waveColor: AppColors.yellow,
                                  backgroundColor: theme!
                                      ? AppColors.white
                                      : AppColors.themeBlack,
                                ),
                              ),
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
