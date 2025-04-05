part of 'find_bloc.dart';

abstract class FindVersionEvent extends Equatable {
  const FindVersionEvent();

  @override
  List<Object> get props => [];
}

class FindVersion extends FindVersionEvent {
  final BuildContext context;

  const FindVersion({
    required this.context,
  });
  @override
  List<Object> get props => [context];
}
