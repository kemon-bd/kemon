part of 'find_bloc.dart';

abstract class FindVersionState extends Equatable {
  const FindVersionState();

  @override
  List<Object> get props => [];
}

class FindVersionInitial extends FindVersionState {
  const FindVersionInitial();
}

class FindVersionLoading extends FindVersionState {
  const FindVersionLoading();
}

class FindVersionError extends FindVersionState {
  final Failure failure;

  const FindVersionError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindVersionDone extends FindVersionState {
  const FindVersionDone();

  @override
  List<Object> get props => [];
}
