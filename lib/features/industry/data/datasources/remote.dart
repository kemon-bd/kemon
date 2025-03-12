import '../../../../core/shared/shared.dart';
import '../../industry.dart';

abstract class IndustryRemoteDataSource {
  FutureOr<List<IndustryModel>> find();
  
  FutureOr<List<IndustryWithListingCountModel>> location({
    required String division,
    String? district,
    String? thana,
  });
}
