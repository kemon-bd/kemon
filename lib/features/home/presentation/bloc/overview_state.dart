part of 'overview_bloc.dart';

sealed class OverviewState extends Equatable {
  const OverviewState();

  @override
  List<Object> get props => [];
}

final class OverviewInitial extends OverviewState {}

final class OverviewLoading extends OverviewState {}

final class OverviewError extends OverviewState {
  final Failure failure;

  const OverviewError({
    required this.failure,
  });
}

final class OverviewDone extends OverviewState {
  final List<CategoryEntity> categories;
  final List<ThanaEntity> locations;
  final List<RecentReviewEntity> reviews;
  final List<BusinessLiteEntity> businesses;

  const OverviewDone({
    required this.categories,
    required this.locations,
    required this.reviews,
    required this.businesses,
  });
}
