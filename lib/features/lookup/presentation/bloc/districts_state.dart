part of 'districts_bloc.dart';

abstract class DistrictsState extends Equatable {
  const DistrictsState();

  @override
  List<Object> get props => [];
}

class DistrictsInitial extends DistrictsState {
  const DistrictsInitial();
}

class DistrictsLoading extends DistrictsState {
  const DistrictsLoading();
}

class DistrictsError extends DistrictsState {
  final Failure failure;

  const DistrictsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class DistrictsDone extends DistrictsState {
  final List<LookupEntity> districts;

  const DistrictsDone({required this.districts});

  @override
  List<Object> get props => [districts];
}
