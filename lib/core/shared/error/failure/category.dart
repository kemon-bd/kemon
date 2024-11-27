part of 'failure.dart';

class CategoryModelParseFailure extends Failure {
  CategoryModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class CategoriesNotFoundInLocalCacheFailure extends Failure {
  CategoriesNotFoundInLocalCacheFailure()
      : super(
          message: 'Categories not found in local cache.',
        );
}

class CategoryNotFoundInLocalCacheFailure extends Failure {
  CategoryNotFoundInLocalCacheFailure()
      : super(
          message: 'Category not found in local cache.',
        );
}
