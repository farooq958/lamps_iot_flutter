part of 'delete_color_cubit.dart';

@immutable
abstract class DeleteColorState {}

class DeleteColorInitial extends DeleteColorState {}

class DeleteColorLoading extends DeleteColorState {}

class DeleteColorSuccess extends DeleteColorState {}

class DeleteColorFailed extends DeleteColorState {}

class DeleteColorError extends DeleteColorState {
  final String? errorMessage;

  DeleteColorError(this.errorMessage);
}
