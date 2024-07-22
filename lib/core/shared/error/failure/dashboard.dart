part of 'failure.dart';

class DashboardModelParseFailure extends Failure {
  DashboardModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class DashboardNotFoundInLocalCacheFailure extends Failure {
  DashboardNotFoundInLocalCacheFailure()
      : super(
          message: 'Dashboard not found in local cache.',
        );
}
