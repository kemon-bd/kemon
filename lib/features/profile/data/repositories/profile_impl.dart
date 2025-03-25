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
    XFile? avatar,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.update(token: auth.token!, profile: profile, avatar: avatar);

        await local.update(profile: profile);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, ProfileEntity>> refresh({
    required Identity identity,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.find(identity: identity);

        await local.add(profile: result);
        auth.add(UpdateAuthorizedProfile(profile: result));
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
  FutureOr<Either<Failure, void>> deactivateAccount({
    required String otp,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.deactivateAccount(
          token: auth.token!,
          username: auth.username!,
          otp: otp,
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
  FutureOr<Either<Failure, String>> generateOtpForAccountDeactivation() async {
    try {
      if (await network.online) {
        final result = await remote.generateOtpForAccountDeactivation(
          token: auth.token!,
          username: auth.username!,
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
  FutureOr<Either<Failure, String>> requestOtpForPasswordChange({
    required String username,
    required bool verificationOnly,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.requestOtpForPasswordChange(
          username: username,
          verificationOnly: verificationOnly,
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
  FutureOr<Either<Failure, void>> resetPassword({
    required String username,
    required String password,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.resetPassword(
          username: username,
          password: password,
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
  FutureOr<Either<Failure, void>> block({
    required Identity victim,
    required String? reason,
  }) async {
    try {
      final token = auth.token;
      if (token == null) {
        return Left(UnAuthorizedFailure());
      }

      final identity = auth.identity;
      if (identity == null) {
        return Left(UnAuthorizedFailure());
      }

      if (await network.online) {
        final result = await remote.block(token: token, user: identity, victim: victim, reason: reason);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<UserPreviewEntity>>> blockList() async {
    try {
      final token = auth.token;
      if (token == null) {
        return Left(UnAuthorizedFailure());
      }

      final identity = auth.identity;
      if (identity == null) {
        return Left(UnAuthorizedFailure());
      }

      if (await network.online) {
        final result = await remote.blockList(token: token, user: identity);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, void>> unblock({
    required Identity victim,
  }) async {
    try {
      final token = auth.token;
      if (token == null) {
        return Left(UnAuthorizedFailure());
      }

      final identity = auth.identity;
      if (identity == null) {
        return Left(UnAuthorizedFailure());
      }

      if (await network.online) {
        final result = await remote.unblock(token: token, user: identity, victim: victim);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
