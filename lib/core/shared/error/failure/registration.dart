part of 'failure.dart';

class RegistrationModelParseFailure extends Failure {
  RegistrationModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class RegistrationNotFoundInLocalCacheFailure extends Failure {
  RegistrationNotFoundInLocalCacheFailure()
      : super(
          message: 'Registration not found in local cache.',
        );
}
