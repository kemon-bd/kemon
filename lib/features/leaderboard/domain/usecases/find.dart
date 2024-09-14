import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class FindLeaderboardUseCase {
  final LeaderboardRepository repository;

  FindLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, LeaderboardEntity>> call({
    required String guid,
  }) async {
    return await repository.find(
      guid: guid,
    );
  }
}
