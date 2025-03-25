part of 'unblock_bloc.dart';

sealed class UnblockEvent extends Equatable {
  const UnblockEvent();

  @override
  List<Object?> get props => [];
}

class UnblockAbuser extends UnblockEvent {
  final Identity abuser;

  const UnblockAbuser({
    required this.abuser,
  });

  @override
  List<Object?> get props => [abuser];
}
