part of 'divisions_bloc.dart';

abstract class DivisionsState extends Equatable {
  const DivisionsState();

  @override
  List<Object> get props => [];
}

class DivisionsInitial extends DivisionsState {
  const DivisionsInitial();
}

class DivisionsLoading extends DivisionsState {
  const DivisionsLoading();
}

class DivisionsError extends DivisionsState {
  final Failure failure;

  const DivisionsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class DivisionsDone extends DivisionsState {
  final List<LookupEntity> divisions;

  const DivisionsDone({required this.divisions});

  @override
  List<Object> get props => [divisions];
}
