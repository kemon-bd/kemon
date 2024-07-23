part of 'failure.dart';

class LocationModelParseFailure extends Failure {
  LocationModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class LocationNotFoundInLocalCacheFailure extends Failure {
  LocationNotFoundInLocalCacheFailure()
      : super(
          message: 'Location not found in local cache.',
        );
}
