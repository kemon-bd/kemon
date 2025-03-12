part of 'location_bloc.dart';

sealed class FindLocationsByCategoryState extends Equatable {
  const FindLocationsByCategoryState();

  @override
  List<Object> get props => [];
}

final class FindLocationsByCategoryInitial extends FindLocationsByCategoryState {}

final class FindLocationsByCategoryLoading extends FindLocationsByCategoryState {}

final class FindLocationsByCategoryError extends FindLocationsByCategoryState {
  final Failure failure;

  const FindLocationsByCategoryError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class FindLocationsByCategoryDone extends FindLocationsByCategoryState {
  final List<DivisionWithListingCountEntity> divisions;

  const FindLocationsByCategoryDone({required this.divisions});

  @override
  List<Object> get props => [divisions];
}
