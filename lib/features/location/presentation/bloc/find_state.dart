part of 'find_bloc.dart';

abstract class FindLocationState extends Equatable {
  const FindLocationState();

  @override
  List<Object> get props => [];
}

class FindLocationInitial extends FindLocationState {
  const FindLocationInitial();
}

class FindLocationLoading extends FindLocationState {
  const FindLocationLoading();
}

class FindLocationError extends FindLocationState {
  final Failure failure;

  const FindLocationError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindLocationDone extends FindLocationState {
  final LocationEntity location;

  const FindLocationDone({required this.location});

  @override
  List<Object> get props => [location];
}
