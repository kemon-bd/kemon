import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessPreviewModel extends BusinessPreviewEntity {
  const BusinessPreviewModel({
    required super.name,
    required super.urlSlug,
    required super.logo,
    required super.verified,
  });

  factory BusinessPreviewModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      return BusinessPreviewModel(
        name: Name.full(name: map['name']),
        urlSlug: map['urlSlug'] ?? map['urlslug'],
        logo: map['logo'] ?? map['icon'],
        verified: map['verified'] ?? false,
      );
    } catch (e, stackTrace) {
      throw BusinessModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
