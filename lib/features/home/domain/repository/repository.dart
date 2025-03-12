import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';

typedef OverviewResponseEntity = (
  List<CategoryEntity>,
  List<ThanaEntity>,
  List<RecentReviewEntity>,
  List<BusinessLiteEntity>,
);

abstract class HomeRepository {
  Future<Either<Failure, OverviewResponseEntity>> overview();
}
