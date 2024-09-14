import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class ReadLeaderboardUseCase {
  final LeaderboardRepository repository;

  ReadLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<LeaderboardEntity>>> call() async {
    return await repository.read();
  }
}
