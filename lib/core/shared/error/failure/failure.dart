//! mason:linking-failures - DO NOT REMOVE THIS COMMENT --------------------------->
import '../../shared.dart';

part 'analytics.dart';
part 'leaderboard.dart';
part 'registration.dart';
part 'search.dart';
part 'review.dart';
part 'business.dart';
part 'location.dart';
part 'lookup.dart';
part 'sub_category.dart';
part 'category.dart';
part 'industry.dart';
part 'home.dart';
part 'profile.dart';
part 'login.dart';
part 'authentication.dart';
part 'listing.dart';
part 'dashboard.dart';
part 'whats_new.dart';
part 'version.dart';

abstract class Failure {
  final String message;
  final StackTrace? stackTrace;

  Failure({
    required this.message,
    this.stackTrace,
  });

  @override
  String toString() => message;
}

class NoInternetFailure extends Failure {
  NoInternetFailure() : super(message: 'No internet connection.');
}

class RemoteFailure extends Failure {
  RemoteFailure({
    required super.message,
  });
}

class UnknownFailure extends Failure {
  UnknownFailure({
    super.message = 'Unknown error.',
    StackTrace? stackTrace,
  });
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure({
    super.message = 'Login required.',
    StackTrace? stackTrace,
  });
}

class FacebookSignInFailure extends Failure {
  FacebookSignInFailure({
    super.message = 'Facebook sign in failed.',
  });
}

class GoogleSignInFailure extends Failure {
  GoogleSignInFailure({
    super.message = 'Google sign in failed.',
  });
}
class AppleSignInFailure extends Failure {
  AppleSignInFailure({
    super.message = 'Apple sign in failed.',
  });
}

class GoogleAccountNotRegisteredFailure extends Failure {
  final GoogleSignInAccount account;
  GoogleAccountNotRegisteredFailure({
    required this.account,
  }) : super(message: 'Google account is not registered.');
}

class FacebookAccountNotRegisteredFailure extends Failure {
  FacebookAccountNotRegisteredFailure() : super(message: 'Facebook account is not registered.');
}

class AppleAccountNotRegisteredFailure extends Failure {
  AppleAccountNotRegisteredFailure() : super(message: 'Apple account is not registered.');
}
