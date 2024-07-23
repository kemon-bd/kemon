part of 'failure.dart';

class CategoryModelParseFailure extends Failure {
  CategoryModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class CategoryNotFoundInLocalCacheFailure extends Failure {
  CategoryNotFoundInLocalCacheFailure()
      : super(
          message: 'Category not found in local cache.',
        );
}
