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
  BusinessNotFoundByCategoryInLocalCacheFailure([String? reason])
      : super(
          message: 'Business not found by category in local cache.${reason?.isNotEmpty ?? false ? '\nReason: $reason' : ''}',
        );
}

class InvalidUrlSlugFailure extends Failure {
  InvalidUrlSlugFailure([String? reason])
      : super(
          message: 'Change Listing name / URLSlug',
        );
}
