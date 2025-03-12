import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessLiteModel extends BusinessLiteEntity implements BusinessPreviewEntity {
  const BusinessLiteModel({
    required super.name,
    required super.urlSlug,
    required super.logo,
    required super.thana,
    required super.district,
    required super.verified,
    required super.reviews,
    required super.rating,
  });

  factory BusinessLiteModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final preview = BusinessPreviewModel.parse(map: map);
      return BusinessLiteModel(
        name: preview.name,
        urlSlug: preview.urlSlug,
        logo: preview.logo,
        verified: map['verified'] ?? false,
        reviews: map['reviews'],
        rating: num.parse(map['rating'].toString()).toDouble(),
        thana: map['thana'],
        district: map['district'],
      );
    } catch (e, stackTrace) {
      throw BusinessModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
