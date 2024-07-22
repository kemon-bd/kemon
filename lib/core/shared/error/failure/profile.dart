part of 'failure.dart';

class ProfileModelParseFailure extends Failure {
  ProfileModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class ProfileNotFoundInLocalCacheFailure extends Failure {
  ProfileNotFoundInLocalCacheFailure()
      : super(
          message: 'Profile not found in local cache.',
        );
}
