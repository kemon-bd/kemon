import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessCoreModel extends BusinessCoreEntity implements BusinessLiteEntity, BusinessPreviewEntity {
  const BusinessCoreModel({
    required super.identity,
    required super.name,
    required super.urlSlug,
    required super.logo,
    required super.verified,
    required super.reviews,
    required super.rating,
    required super.thana,
    required super.district,
  });

  factory BusinessCoreModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final lite = BusinessLiteModel.parse(map: map);
      return BusinessCoreModel(
        identity: Identity(id: map['id'], guid: map['guid']),
        name: lite.name,
        urlSlug: lite.urlSlug,
        logo: lite.logo,
        verified: lite.verified,
        reviews: lite.reviews,
        rating: lite.rating,
        thana: lite.thana,
        district: lite.district,
      );
    } catch (e, stackTrace) {
      throw BusinessModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
