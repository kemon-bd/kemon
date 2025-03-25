part of 'block_bloc.dart';

sealed class BlockState extends Equatable {
  const BlockState();

  @override
  List<Object> get props => [];
}

final class BlockInitial extends BlockState {}

final class BlockLoading extends BlockState {}

final class BlockError extends BlockState {
  final Failure failure;

  const BlockError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class BlockDone extends BlockState {}
