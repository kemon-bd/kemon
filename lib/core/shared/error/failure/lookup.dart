part of 'failure.dart';

class LookupModelParseFailure extends Failure {
  LookupModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class LookupNotFoundInLocalCacheFailure extends Failure {
  LookupNotFoundInLocalCacheFailure()
      : super(
          message: 'Lookup not found in local cache.',
        );
}
