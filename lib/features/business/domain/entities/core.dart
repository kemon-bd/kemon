import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessCoreEntity extends BusinessLiteEntity {
  final Identity identity;

  const BusinessCoreEntity({
    required this.identity,
    required super.reviews,
    required super.name,
    required super.urlSlug,
    required super.logo,
    required super.rating,
    required super.verified,
    required super.thana,
    required super.district,
  });

  @override
  List<Object?> get props => [
        identity,
        name,
        urlSlug,
        logo,
        verified,
        rating,
        reviews,
        thana,
        district,
      ];
}
