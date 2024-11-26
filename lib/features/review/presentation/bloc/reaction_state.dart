part of 'reaction_bloc.dart';

sealed class ReactionState extends Equatable {
  const ReactionState();

  @override
  List<Object> get props => [];
}

final class ReactionInitial extends ReactionState {}

final class ReactionError extends ReactionState {
  final Failure failure;

  const ReactionError({
    required this.failure,
  });
}

final class ReactionLoading extends ReactionState {}

final class ReactionDone extends ReactionState {
  final List<ReactionEntity> reactions;

  const ReactionDone({
    required this.reactions,
  });
}
