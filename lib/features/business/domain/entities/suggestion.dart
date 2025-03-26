import '../../../search/search.dart';
import '../../business.dart';

class BusinessSuggestionEntity extends BusinessPreviewEntity implements SearchSuggestionEntity, SearchSuggestionModel {
  final double rating;
  final int reviews;

  const BusinessSuggestionEntity({
    required super.name,
    required super.urlSlug,
    required super.logo,
    required super.verified,
    required this.rating,
    required this.reviews,
  });
}
