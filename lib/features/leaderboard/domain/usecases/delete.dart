import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class DeleteLeaderboardUseCase {
  final LeaderboardRepository repository;

  DeleteLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required String guid,
  }) async {
    return await repository.delete(
      guid: guid,
    );
  }
}
