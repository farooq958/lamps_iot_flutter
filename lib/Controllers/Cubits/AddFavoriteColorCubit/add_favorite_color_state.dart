part of 'add_favorite_color_cubit.dart';

@immutable
abstract class AddFavoriteColorState {}

class AddFavoriteColorInitial extends AddFavoriteColorState {}

class AddFavoriteColorLoading extends AddFavoriteColorState {}

class AddFavoriteColorSuccess extends AddFavoriteColorState {}

class AddFavoriteColorFailed extends AddFavoriteColorState {}

class AddFavoriteColorError extends AddFavoriteColorState {
  final String? errorMessage;

  AddFavoriteColorError(this.errorMessage);
}
