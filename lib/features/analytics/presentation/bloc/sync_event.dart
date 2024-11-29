part of 'sync_bloc.dart';

abstract class SyncAnalyticsEvent extends Equatable {
  const SyncAnalyticsEvent();

  @override
  List<Object> get props => [];
}

class SyncAnalytics extends SyncAnalyticsEvent {
  final AnalyticSource source;
  final String referrer;
  final Identity listing;
  const SyncAnalytics({
    required this.source,
    required this.referrer,
    required this.listing,
  });
  @override
  List<Object> get props => [
        source,
        referrer,
        listing,
      ];
}
