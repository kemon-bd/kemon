import '../../business.dart';

class BusinessLiteEntity extends BusinessPreviewEntity {
  final String? thana;
  final String? district;
  final double rating;
  final int reviews;

  const BusinessLiteEntity({
    required super.name,
    required super.urlSlug,
    required super.logo,
    required this.thana,
    required this.district,
    required this.rating,
    required this.reviews,
    required super.verified,
  });

  @override
  List<Object?> get props => [
        name,
        urlSlug,
        logo,
        thana,
        district,
        rating,
        reviews,
        verified,
      ];
}
