import '../../../../core/shared/shared.dart';
import '../../business.dart';

abstract class BusinessRepository {
  FutureOr<Either<Failure, BusinessEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<BusinessEntity>>> category({
    required String category,
  });
}
