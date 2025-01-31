import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class NewListingUseCase {
  final BusinessRepository repository;

  NewListingUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, String>> call({
    required String name,
    required String urlSlug,
    required String about,
    required XFile? logo,
    required ListingType type,
    required String phone,
    required String email,
    required String website,
    required String social,
    required IndustryEntity industry,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required String address,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
  }) async {
    return await repository.publish(
      name: name,
      urlSlug: urlSlug,
      about: about,
      logo: logo,
      type: type,
      phone: phone,
      email: email,
      website: website,
      social: social,
      industry: industry,
      category: category,
      subCategory: subCategory,
      address: address,
      division: division,
      district: district,
      thana: thana,
    );
  }
}
