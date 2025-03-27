import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../profile/profile.dart';
import '../../../registration/registration.dart';
import '../../login.dart';

class LoginRepositoryImpl extends LoginRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final LoginRemoteDataSource remote;
  final GoogleDataSource google;
  final FacebookDataSource facebook;
  final RegistrationRemoteDataSource registration;

  LoginRepositoryImpl({
    required this.network,
    required this.auth,
    required this.remote,
    required this.facebook,
    required this.google,
    required this.registration,
  });

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

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, ProfileEntity>> fbLogin() async {
    try {
      if (await network.online) {
        await facebook.logout();
        final account = await facebook.login();
        ProfileModel? profile = await remote.socialLogin(id: account['id']);

        if (profile == null) {
          await registration.registerWithFacebook(facebook: account);
          profile = await remote.socialLogin(id: account['id']);
        }

        if (profile != null) {
          final result = await remote.login(username: account['id'], password: account['id']);
          auth.add(
            AuthorizeAuthentication(
              token: result.token,
              profile: result.profile,
              username: account['id'],
              password: account['id'],
              remember: true,
            ),
          );

          await Future.delayed(const Duration(milliseconds: 1));
          return Right(result.profile);
        } else {
          return Left(FacebookSignInFailure());
        }
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, ProfileEntity>> googleSignIn() async {
    try {
      if (await network.online) {
        await google.logout();
        final account = await google.login();
        ProfileModel? profile = await remote.socialLogin(id: account.id);

        if (profile == null) {
          await registration.registerWithGoogle(google: account);
          profile = await remote.socialLogin(id: account.id);
        }
        if (profile != null) {
          final result = await remote.login(username: account.id, password: account.id);
          auth.add(
            AuthorizeAuthentication(
              token: result.token,
              profile: result.profile,
              username: account.id,
              password: account.id,
              remember: true,
            ),
          );

          await Future.delayed(const Duration(milliseconds: 1));
          return Right(result.profile);
        } else {
          return Left(GoogleSignInFailure());
        }
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, ProfileEntity>> appleSignIn() async {
    try {
      if (await network.online) {
        final account = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        final appleIdentifier = account.userIdentifier;
        if (appleIdentifier == null) {
          return Left(AppleSignInFailure());
        }
        ProfileModel? profile = await remote.socialLogin(id: appleIdentifier);

        if (profile == null) {
          await registration.registerWithApple(apple: account);
          profile = await remote.socialLogin(id: appleIdentifier);
        }
        if (profile != null) {
          final result = await remote.login(username: appleIdentifier, password: appleIdentifier);
          auth.add(
            AuthorizeAuthentication(
              token: result.token,
              profile: result.profile,
              username: appleIdentifier,
              password: appleIdentifier,
              remember: true,
            ),
          );

          await Future.delayed(const Duration(milliseconds: 1));
          return Right(result.profile);
        } else {
          return Left(AppleSignInFailure());
        }
      } else {
        return Left(NoInternetFailure());
      }
    } on SignInWithAppleAuthorizationException {
      return Left(AppleSignInFailure());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
