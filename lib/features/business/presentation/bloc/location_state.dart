part of 'location_bloc.dart';

abstract class FindBusinessesByLocationState extends Equatable {
  const FindBusinessesByLocationState();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByLocationInitial extends FindBusinessesByLocationState {
  const FindBusinessesByLocationInitial() : super();
}

class FindBusinessesByLocationLoading extends FindBusinessesByLocationState {
  const FindBusinessesByLocationLoading();
}

class FindBusinessesByLocationError extends FindBusinessesByLocationState {
  final Failure failure;

  const FindBusinessesByLocationError({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

class FindBusinessesByLocationDone extends FindBusinessesByLocationState {
  final List<BusinessLiteEntity> businesses;

  const FindBusinessesByLocationDone({
    required this.businesses,
  });

  @override
  List<Object?> get props => [businesses];
}

