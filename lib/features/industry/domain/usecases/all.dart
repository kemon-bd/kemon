import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class FindIndustriesUseCase {
  final IndustryRepository repository;

  FindIndustriesUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<IndustryEntity>>> call() async {
    return await repository.all ();
  }
}
