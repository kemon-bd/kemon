part of 'failure.dart';

class HomeModelParseFailure extends Failure {
  HomeModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class HomeNotFoundInLocalCacheFailure extends Failure {
  HomeNotFoundInLocalCacheFailure()
      : super(
          message: 'Home not found in local cache.',
        );
}
