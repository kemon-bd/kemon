import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../analytics.dart';

class AnalyticsRepositoryImpl extends AnalyticsRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final AnalyticsRemoteDataSource remote;

  AnalyticsRepositoryImpl({
    required this.network,
    required this.auth,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, void>> sync({
    required AnalyticSource source,
    required String referrer,
    required Identity listing,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.sync(source: source, referrer: referrer, listing: listing, user: auth.identity);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
