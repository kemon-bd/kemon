import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';

typedef OverviewResponseModel = (List<CategoryModel>, List<ThanaModel>, List<RecentReviewModel>, List<BusinessLiteModel>);

abstract class HomeRemoteDatasource {
  Future<OverviewResponseModel> find({
    required Identity? user,
  });
}
