import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/audio_player_visibility_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/play_pause_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/player_bottom_sheet_visibility_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/search_list_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/MainScreenViews/main_screen.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/AudioPlayer/audio_player_app_bar.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/AudioPlayer/audio_player_custom_serch_field.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/AudioPlayer/custom_bottom_sheet.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/AudioPlayer/custom_no_song_design.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/AudioPlayer/custom_songs_loading_design.dart';
import 'package:keptua/Views/Utils/CutsomWidgets/AudioPlayer/music_list.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_shared_preferences.dart';
import 'package:keptua/Views/Utils/PageTransitions/slide_page_transition.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MainAudioPlayerScreen extends StatefulWidget {
  final bool? theme;

  const MainAudioPlayerScreen({super.key, required this.theme});

  @override
  State<MainAudioPlayerScreen> createState() => _MainAudioPlayerScreenState();
}

class _MainAudioPlayerScreenState extends State<MainAudioPlayerScreen> {
  @override
  void initState() {
    super.initState();
    requestPermission();
    playSong();
  }

  void playSong() {}

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Set Shared preference route
        SharedPrefs.setInitPage(initPage: 'installed');
        //navigate to previous screen
        Navigator.push(
          context,
          CustomSlidePageRoute(
            direction: AxisDirection.right,
            child: const MainScreen(),
          ),
        );
        return false;
      },
      child: BlocBuilder<AudioPlayerVisibilityCubit, bool>(
        builder: (context, audioPlayerVisibilityState) {
          return BlocBuilder<PlayerBottomSheetVisibilityCubit, bool>(
            builder: (context, playerBottomSheetVisibilityState) {
              return FutureBuilder<List<SongModel>>(
                future: Repository.audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.DESC_OR_GREATER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, songItems) {
                  if (songItems.data == null) {
                    context
                        .read<AudioPlayerVisibilityCubit>()
                        .visibility(false);
                    return CustomSongsLoadingDesign(theme: widget.theme);
                  } else if (songItems.data!.isEmpty) {
                    context
                        .read<AudioPlayerVisibilityCubit>()
                        .visibility(false);
                    return CustomNoSongFoundDesign(theme: widget.theme);
                  } else {
                    context.read<AudioPlayerVisibilityCubit>().visibility(true);
                    storeFetchedSongs(songItems: songItems);
                    return BlocBuilder<PlayPauseCubit, bool>(
                      builder: (context, playPauseState) {
                        return BlocBuilder<SearchListCubit, List>(
                          builder: (context, searchedList) {
                            return Scaffold(
                              bottomSheet: audioPlayerVisibilityState &&
                                      playerBottomSheetVisibilityState
                                  ? CustomAudioPlayerBottomSheet(
                                      theme: widget.theme,
                                      songItems: songItems,
                                      playPauseState: playPauseState,
                                      searchedList: searchedList,
                                    )
                                  : const SizedBox(),
                              body: Container(
                                height: 1.sh,
                                width: 1.sw,
                                color: widget.theme!
                                    ? AppColors.white
                                    : AppColors.themeBlack,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(vertical: 38.sp),
                                  children: [
                                    //app bar
                                    AudioPlayerAppBar(theme: widget.theme),
                                    Container(
                                      height: 15.sp,
                                      padding: EdgeInsets.zero,
                                      color: SharedPrefs.getTheme() == true ||
                                              SharedPrefs.getTheme() == null
                                          ? AppColors.white
                                          : AppColors.themeBlack,
                                    ),

                                    //custom search text field
                                    audioPlayerVisibilityState
                                        ? AudioPlayerCustomSearchField(
                                            theme: widget.theme,
                                            songItems: songItems,
                                          )
                                        : const SizedBox(),

                                    Container(
                                      height: 15.sp,
                                      padding: EdgeInsets.zero,
                                      color: SharedPrefs.getTheme() == true ||
                                              SharedPrefs.getTheme() == null
                                          ? AppColors.white
                                          : AppColors.themeBlack,
                                    ),

                                    //music list
                                    MusicList(
                                      theme: widget.theme,
                                      bottomSheetVisibilityState:
                                          playerBottomSheetVisibilityState,
                                      songItems: songItems,
                                      playPauseState: playPauseState,
                                      searchedList: searchedList,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  void storeFetchedSongs(
      {required AsyncSnapshot<List<SongModel>> songItems}) async {
    Repository.fetchedSongList = songItems.data!.toList();
    Repository.songsList = List.from(Repository.fetchedSongList);
    context.read<SearchListCubit>().songsList(Repository.songsList);
    // debugPrint('songs path ${songItems.data[0]}');
    debugPrint('songs are fetched here ${Repository.songsList}');
  }
}
