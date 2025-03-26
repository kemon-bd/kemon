import '../../../search/search.dart';
import '../../business.dart';

class BusinessSuggestionModel extends BusinessSuggestionEntity
    implements BusinessPreviewEntity, BusinessPreviewModel, SearchSuggestionEntity, SearchSuggestionModel {
  const BusinessSuggestionModel({
    required super.name,
    required super.urlSlug,
    required super.logo,
    required super.rating,
    required super.reviews,
    required super.verified,
  });

  factory BusinessSuggestionModel.parse({
    required Map<String, dynamic> map,
  }) {
    final preview = BusinessPreviewModel.parse(map: map);
    return BusinessSuggestionModel(
      name: preview.name,
      urlSlug: preview.urlSlug,
      logo: preview.logo,
      verified: preview.verified,
      rating: num.tryParse(map['rating'].toString())?.toDouble() ?? 0.0,
      reviews: num.tryParse(map['reviews'].toString())?.toInt() ?? 0,
    );
  }
}
