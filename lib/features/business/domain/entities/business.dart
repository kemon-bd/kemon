import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessEntity extends BusinessCoreEntity {
  final ListingType type;
  final bool claimed;
  final Address address;
  final Contact contact;
  final String social;
  final String about;

  const BusinessEntity({
    required super.rating,
    required super.reviews,
    required this.social,
    required super.identity,
    required super.name,
    required super.urlSlug,
    required this.about,
    required super.logo,
    required this.type,
    required this.claimed,
    required super.verified,
    required this.address,
    required this.contact,
    required super.thana,
    required super.district,
    
  });

  @override
  List<Object?> get props => [
        identity,
        name,
        urlSlug,
        about,
        logo,
        type,
        claimed,
        verified,
        address,
        contact,
        social,
        rating,
        reviews,
        thana,
        district,
      ];
}
