part of 'fetch_favorite_colors_cubit.dart';

@immutable
abstract class FetchFavoriteColorsState {}

class FetchFavoriteColorsInitial extends FetchFavoriteColorsState {}

class FetchFavoriteColorsLoading extends FetchFavoriteColorsState {}

class FetchFavoriteColorsSuccess extends FetchFavoriteColorsState {}

class FetchFavoriteColorsEmpty extends FetchFavoriteColorsState {}

class FetchFavoriteColorsError extends FetchFavoriteColorsState {
  final String? errorMessage;

  FetchFavoriteColorsError(this.errorMessage);
}
