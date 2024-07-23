part of 'find_bloc.dart';

abstract class FindLookupState extends Equatable {
  const FindLookupState();

  @override
  List<Object> get props => [];
}

class FindLookupInitial extends FindLookupState {
  const FindLookupInitial();
}

class FindLookupLoading extends FindLookupState {
  const FindLookupLoading();
}

class FindLookupError extends FindLookupState {
  final Failure failure;

  const FindLookupError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindLookupDone extends FindLookupState {
  final List<LookupEntity> lookups;

  const FindLookupDone({required this.lookups});

  @override
  List<Object> get props => [lookups];
}
