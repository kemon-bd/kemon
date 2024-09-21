part of 'failure.dart';

class WhatsNewModelParseFailure extends Failure {
  WhatsNewModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class WhatsNewNotFoundInLocalCacheFailure extends Failure {
  WhatsNewNotFoundInLocalCacheFailure()
      : super(
          message: 'WhatsNew not found in local cache.',
        );
}
