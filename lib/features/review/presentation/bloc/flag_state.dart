part of 'flag_bloc.dart';

sealed class FlagState extends Equatable {
  const FlagState();

  @override
  List<Object> get props => [];
}

final class FlagInitial extends FlagState {}

final class FlagLoading extends FlagState {}

final class FlagError extends FlagState {
  final Failure failure;
  const FlagError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

final class FlagDone extends FlagState {}
