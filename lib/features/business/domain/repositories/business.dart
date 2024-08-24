import '../../../../core/shared/shared.dart';
import '../../business.dart';

typedef BusinessesByCategoryPaginatedResponse = ({
  int total,
  List<BusinessEntity> businesses,
});

abstract class BusinessRepository {
  FutureOr<Either<Failure, BusinessEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> category({
    required int page,
    required String category,
  });
}
