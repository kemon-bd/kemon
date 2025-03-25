part of 'block_bloc.dart';

sealed class BlockEvent extends Equatable {
  const BlockEvent();

  @override
  List<Object?> get props => [];
}

class BlockAbuser extends BlockEvent {
  final Identity abuser;
  final String? reason;
  
  const BlockAbuser({
    required this.abuser,
    required this.reason,
  });

  @override
  List<Object?> get props => [abuser, reason];
}
