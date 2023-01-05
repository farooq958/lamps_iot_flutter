import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keptua/Controllers/Cubits/AddFavoriteColorCubit/add_favorite_color_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/audio_player_visibility_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/first_song_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/item_wave_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/last_song_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/play_pause_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/player_bottom_sheet_visibility_cubit.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/search_list_cubit.dart';
import 'package:keptua/Controllers/Cubits/DeleteColorCubit/delete_color_cubit.dart';
import 'package:keptua/Controllers/Cubits/FavoriteColorsCubits/fetch_favorite_colors_cubit.dart';
import 'package:keptua/Controllers/Cubits/default_colors_cubit.dart';
import 'package:keptua/Controllers/Cubits/favorite_cubit.dart';
import 'package:keptua/Controllers/Cubits/onboarding_page_index_cubit.dart';
import 'package:keptua/Controllers/Cubits/opacity_cubit.dart';
import 'package:keptua/Controllers/Cubits/power_cubit.dart';
import 'package:keptua/Controllers/Cubits/theme_cubit.dart';
import 'package:keptua/Controllers/Cubits/waves_cubit.dart';

final List<BlocProvider> mainCubitProvidersList = [
  BlocProvider<PowerCubit>(
    create: (context) => PowerCubit(false),
  ),
  BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit(false),
  ),
  BlocProvider<FavoriteCubit>(
    create: (context) => FavoriteCubit(false),
  ),
  BlocProvider<WavesCubit>(
    create: (context) => WavesCubit(false),
  ),
  BlocProvider<DefaultColorsCubit>(
    create: (context) => DefaultColorsCubit(colorIndex: 0),
  ),
  BlocProvider<OnboardingPageIndexCubit>(
    create: (context) => OnboardingPageIndexCubit(0),
  ),
  BlocProvider<FetchFavoriteColorsCubit>(
    create: (context) => FetchFavoriteColorsCubit(),
  ),
  BlocProvider<AddFavoriteColorCubit>(
    create: (context) => AddFavoriteColorCubit(),
  ),
  BlocProvider<DeleteColorCubit>(
    create: (context) => DeleteColorCubit(),
  ),
  BlocProvider<OpacityCubit>(
    create: (context) => OpacityCubit(0.0),
  ),
  BlocProvider<AudioPlayerVisibilityCubit>(
    create: (context) => AudioPlayerVisibilityCubit(true),
  ),
  BlocProvider<PlayPauseCubit>(
    create: (context) => PlayPauseCubit(false),
  ),
  BlocProvider<PlayerBottomSheetVisibilityCubit>(
    create: (context) => PlayerBottomSheetVisibilityCubit(false),
  ),
  BlocProvider<FirstSongCubit>(
    create: (context) => FirstSongCubit(false),
  ),
  BlocProvider<LastSongCubit>(
    create: (context) => LastSongCubit(false),
  ),
  BlocProvider<SearchListCubit>(
    create: (context) => SearchListCubit([]),
  ),
  BlocProvider<ItemWaveCubit>(
    create: (context) => ItemWaveCubit(songItemIndex: 0),
  ),
];
