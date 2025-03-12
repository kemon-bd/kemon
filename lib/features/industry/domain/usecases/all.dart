import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class FindIndustriesUseCase {
  final IndustryRepository repository;

  FindIndustriesUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<IndustryEntity>>> call({
    required String? query,
  }) async {
    return await repository.all(query: query);
  }
}
