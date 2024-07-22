part of 'failure.dart';

class AuthenticationModelParseFailure extends Failure {
  AuthenticationModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class AuthenticationNotFoundInLocalCacheFailure extends Failure {
  AuthenticationNotFoundInLocalCacheFailure()
      : super(
          message: 'Authentication not found in local cache.',
        );
}
