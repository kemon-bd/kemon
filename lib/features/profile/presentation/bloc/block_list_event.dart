part of 'block_list_bloc.dart';

sealed class BlockListEvent extends Equatable {
  const BlockListEvent();

  @override
  List<Object?> get props => [];
}

class FindBlockList extends BlockListEvent {
  const FindBlockList();

  @override
  List<Object?> get props => [];
}
