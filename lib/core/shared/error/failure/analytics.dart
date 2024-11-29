part of 'failure.dart';

class AnalyticsModelParseFailure extends Failure {
  AnalyticsModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class AnalyticsNotFoundInLocalCacheFailure extends Failure {
  AnalyticsNotFoundInLocalCacheFailure()
      : super(
          message: 'Analytics not found in local cache.',
        );
}
