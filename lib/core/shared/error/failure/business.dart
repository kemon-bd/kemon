part of 'failure.dart';

class BusinessModelParseFailure extends Failure {
  BusinessModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class BusinessNotFoundInLocalCacheFailure extends Failure {
  BusinessNotFoundInLocalCacheFailure()
      : super(
          message: 'Business not found in local cache.',
        );
}

class BusinessNotFoundByCategoryInLocalCacheFailure extends Failure {
  BusinessNotFoundByCategoryInLocalCacheFailure()
      : super(
          message: 'Business not found by category in local cache.',
        );
}
