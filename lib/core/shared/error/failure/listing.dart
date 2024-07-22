part of 'failure.dart';

class ListingModelParseFailure extends Failure {
  ListingModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class ListingNotFoundInLocalCacheFailure extends Failure {
  ListingNotFoundInLocalCacheFailure()
      : super(
          message: 'Listing not found in local cache.',
        );
}
