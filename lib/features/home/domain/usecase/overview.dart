import '../../../../core/shared/shared.dart';
import '../../home.dart';

class HomeOverviewUsecase {
  final HomeRepository repository;

  HomeOverviewUsecase({required this.repository});

  Future<Either<Failure, OverviewResponseEntity>> call() async {
    return repository.overview();
  }
}
