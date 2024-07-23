part of 'failure.dart';

class SubCategoryModelParseFailure extends Failure {
  SubCategoryModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class SubCategoryNotFoundInLocalCacheFailure extends Failure {
  SubCategoryNotFoundInLocalCacheFailure()
      : super(
          message: 'SubCategory not found in local cache.',
        );
}
