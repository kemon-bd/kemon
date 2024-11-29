import '../../../../core/shared/shared.dart';

abstract class AnalyticsRepository {
  FutureOr<Either<Failure, void>> sync({
    required AnalyticSource source,
    required String referrer,
    required Identity listing,
  });
}
