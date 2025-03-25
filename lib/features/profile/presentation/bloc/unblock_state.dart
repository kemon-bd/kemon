part of 'unblock_bloc.dart';

sealed class UnblockState extends Equatable {
  const UnblockState();

  @override
  List<Object> get props => [];
}

final class UnblockInitial extends UnblockState {}

final class UnblockLoading extends UnblockState {}

final class UnblockError extends UnblockState {
  final Failure failure;

  const UnblockError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class UnblockDone extends UnblockState {}
