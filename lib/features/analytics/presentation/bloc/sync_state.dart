part of 'sync_bloc.dart';

abstract class SyncAnalyticsState extends Equatable {
  const SyncAnalyticsState();

  @override
  List<Object> get props => [];
}

class SyncAnalyticsInitial extends SyncAnalyticsState {
  const SyncAnalyticsInitial();
}

class SyncAnalyticsLoading extends SyncAnalyticsState {
  const SyncAnalyticsLoading();
}

class SyncAnalyticsError extends SyncAnalyticsState {
  final Failure failure;

  const SyncAnalyticsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class SyncAnalyticsDone extends SyncAnalyticsState {
  const SyncAnalyticsDone();

  @override
  List<Object> get props => [];
}
