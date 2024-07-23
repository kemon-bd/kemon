part of 'failure.dart';

class IndustryModelParseFailure extends Failure {
  IndustryModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class IndustryNotFoundInLocalCacheFailure extends Failure {
  IndustryNotFoundInLocalCacheFailure()
      : super(
          message: 'Industry not found in local cache.',
        );
}
