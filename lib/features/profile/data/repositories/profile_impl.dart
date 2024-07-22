import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final ProfileLocalDataSource local;
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl({
    required this.network,
    required this.auth,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, CheckResponse>> check({
    required String username,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.check(username: username);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, void>> delete({
    required Identity identity,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.delete(token: auth.token!, identity: identity);

        await local.remove(identity: identity);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, ProfileEntity>> find({
    required Identity identity,
  }) async {
    try {
      final result = await local.find(identity: identity);
      return Right(result);
    } on ProfileNotFoundInLocalCacheFailure {
      if (await network.online) {
        final result = await remote.find(identity: identity);

        await local.add(profile: result);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, void>> update({
    required ProfileEntity profile,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.update(token: auth.token!, profile: profile);

        await local.update(profile: profile);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
