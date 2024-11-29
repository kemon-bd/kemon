import '../../../../core/shared/shared.dart';
import '../../analytics.dart';

class SyncAnalyticsUseCase {
  final AnalyticsRepository repository;

  SyncAnalyticsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required AnalyticSource source,
    required String referrer,
    required Identity listing,
  }) async {
    return await repository.sync(source: source, referrer: referrer, listing: listing);
  }
}
