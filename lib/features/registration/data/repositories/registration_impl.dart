import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../login/login.dart';
import '../../../profile/profile.dart';
import '../../registration.dart';

class RegistrationRepositoryImpl extends RegistrationRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final ProfileRemoteDataSource profile;
  final RegistrationRemoteDataSource remote;
  final LoginRemoteDataSource login;

  RegistrationRepositoryImpl({
    required this.network,
    required this.auth,
    required this.profile,
    required this.remote,
    required this.login,
  });

  @override
  FutureOr<Either<Failure, Identity>> create({
    required String username,
    required String password,
    required String refference,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.create(
          username: username,
          password: password,
          refference: refference,
        );

        final response =
            await login.login(username: username, password: password);

        auth.add(
          AuthorizeAuthentication(
            username: username,
            password: password,
            remember: false,
            token: response.token,
            profile: response.profile,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 1));

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, String>> otp({
    required String username,
  }) async {
    try {
      if (await network.online) {
        final result = await profile.check(username: username);

        if (result.isLeft) {
          return Right(result.left);
        } else {
          throw OtpNotSentBecauseUserAlreadyExistsFailure();
        }
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
