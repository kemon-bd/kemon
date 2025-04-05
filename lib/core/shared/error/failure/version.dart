part of 'failure.dart';

class VersionModelParseFailure extends Failure {
  VersionModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class VersionNotFoundInLocalCacheFailure extends Failure {
  VersionNotFoundInLocalCacheFailure()
      : super(
          message: 'Version not found in local cache.',
        );
}
