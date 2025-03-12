import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class FindIndustriesByLocationUseCase {
  final IndustryRepository repository;

  FindIndustriesByLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<IndustryWithListingCountModel>>> call({
    required String? query,
    required String division,
    String? district,
    String? thana,
  }) async {
    return await repository.location(query: query, division: division, district: district, thana: thana);
  }
}
