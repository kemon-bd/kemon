part of 'location_bloc.dart';

sealed class FindIndustriesByLocationState extends Equatable {
  const FindIndustriesByLocationState();

  @override
  List<Object> get props => [];
}

final class FindIndustriesByLocationInitial extends FindIndustriesByLocationState {}

final class FindIndustriesByLocationLoading extends FindIndustriesByLocationState {}

final class FindIndustriesByLocationError extends FindIndustriesByLocationState {
  final Failure failure;

  const FindIndustriesByLocationError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class FindIndustriesByLocationDone extends FindIndustriesByLocationState {
  final List<IndustryWithListingCountModel> industries;

  const FindIndustriesByLocationDone({required this.industries});

  @override
  List<Object> get props => [industries];
}
