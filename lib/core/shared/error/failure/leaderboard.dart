part of 'failure.dart';

class LeaderboardModelParseFailure extends Failure {
  LeaderboardModelParseFailure({
    required super.message,
    required super.stackTrace,
  });
}

class LeaderboardNotFoundInLocalCacheFailure extends Failure {
  LeaderboardNotFoundInLocalCacheFailure()
      : super(
          message: 'Leaderboard not found in local cache.',
        );
}
