import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../home.dart';

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final HomeRemoteDatasource remote;
  final CategoryLocalDataSource category;
  final LocationLocalDataSource location;

  HomeRepositoryImpl({
    required this.auth,
    required this.remote,
    required this.network,
    required this.category,
    required this.location,
  });

  @override
  Future<Either<Failure, OverviewResponseEntity>> overview() async {
    try {
      if (!(await network.online)) {
        return Left(NoInternetFailure());
      }
      final response = await remote.find(user: auth.identity);
      for (CategoryEntity c in response.$1) {
        category.add(urlSlug: c.urlSlug, category: c);
      }
      for (LocationEntity l in response.$2) {
        location.add(urlSlug: l.urlSlug, location: l);
      }
      return Right(response);
    } on SocketException catch (error) {
      return Left(RemoteFailure(message: error.message));
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
