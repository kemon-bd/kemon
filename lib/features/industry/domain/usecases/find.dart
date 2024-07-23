import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class FindIndustryUseCase {
  final IndustryRepository repository;

  FindIndustryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<IndustryEntity>>> call() async {
    return await repository.find();
  }
}
