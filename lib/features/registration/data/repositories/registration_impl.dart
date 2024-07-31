import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../registration.dart';

class RegistrationRepositoryImpl extends RegistrationRepository {
  final NetworkInfo network;
  final ProfileRemoteDataSource profile;
  final RegistrationRemoteDataSource remote;

  RegistrationRepositoryImpl({
    required this.network,
    required this.profile,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, void>> create({
    required String username,
    required String password,
    required String refference,
    required Name name,
    required Contact contact,
    required DateTime dob,
    required Gender gender,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.create(
          username: username,
          password: password,
          refference: refference,
          name: name,
          contact: contact,
          dob: dob,
          gender: gender,
        );

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
