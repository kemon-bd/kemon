import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../login.dart';

class LoginRepositoryImpl extends LoginRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final LoginRemoteDataSource remote;

  LoginRepositoryImpl({
    required this.network,
    required this.auth,
    required this.remote,
  });

  @override
  Future<Either<Failure, void>> apple() async {
    try {
      if (await network.online) {
        final id = await remote.apple();

        return login(username: id, password: 'apple', remember: false);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> facebook() async {
    try {
      if (await network.online) {
        final id = await remote.facebook();

        return login(username: id, password: 'facebook', remember: false);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, void>> forgot({
    required String username,
  }) async {
    try {
      if (await network.online) {
        await remote.forgot(username: username);

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> google() async {
    try {
      if (await network.online) {
        final id = await remote.google();

        return login(username: id, password: 'google', remember: false);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, void>> login({
    required String username,
    required String password,
    required bool remember,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.login(
          username: username,
          password: password,
        );

        auth.add(
          AuthorizeAuthentication(
            token: result.token,
            profile: result.profile,
            username: username,
            password: password,
            remember: remember,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 1));

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
