import '../../../../core/shared/shared.dart';
import '../../industry.dart';

abstract class IndustryRepository {
  FutureOr<Either<Failure, IndustryEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<IndustryEntity>>> all({
    required String? query,
  });

  FutureOr<Either<Failure, List<IndustryWithListingCountModel>>> location({
    required String? query,
    required String division,
    String? district,
    String? thana,
  });
}
