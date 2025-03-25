part of 'block_list_bloc.dart';

sealed class BlockListState extends Equatable {
  const BlockListState();

  @override
  List<Object> get props => [];
}

final class BlockListInitial extends BlockListState {}

final class BlockListLoading extends BlockListState {}

final class BlockListError extends BlockListState {
  final Failure failure;

  const BlockListError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class BlockListDone extends BlockListState {
  final List<UserPreviewEntity> users;

  const BlockListDone({required this.users});

  @override
  List<Object> get props => [users];
}
