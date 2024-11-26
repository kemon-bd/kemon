part of 'reaction_bloc.dart';

sealed class ReactionEvent extends Equatable {
  const ReactionEvent();

  @override
  List<Object> get props => [];
}

class FindReaction extends ReactionEvent {
  final Identity review;

  const FindReaction({
    required this.review,
  });
}