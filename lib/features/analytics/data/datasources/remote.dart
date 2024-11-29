import '../../../../core/shared/shared.dart';

abstract class AnalyticsRemoteDataSource {
  FutureOr<void> sync({
    required AnalyticSource source,
    required String referrer,
    required Identity listing,
    required Identity? user,
  });
}
