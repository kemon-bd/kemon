part of 'thanas_bloc.dart';

abstract class ThanasState extends Equatable {
  const ThanasState();

  @override
  List<Object> get props => [];
}

class ThanasInitial extends ThanasState {
  const ThanasInitial();
}

class ThanasLoading extends ThanasState {
  const ThanasLoading();
}

class ThanasError extends ThanasState {
  final Failure failure;

  const ThanasError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class ThanasDone extends ThanasState {
  final List<LookupEntity> thanas;

  const ThanasDone({required this.thanas});

  @override
  List<Object> get props => [thanas];
}
