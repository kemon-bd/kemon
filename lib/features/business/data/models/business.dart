import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessModel extends BusinessEntity implements BusinessCoreEntity, BusinessLiteEntity, BusinessPreviewEntity {
  const BusinessModel({
    required super.identity,
    required super.name,
    required super.urlSlug,
    required super.about,
    required super.logo,
    required super.type,
    required super.claimed,
    required super.verified,
    required super.address,
    required super.contact,
    required super.social,
    required super.reviews,
    required super.rating,
    required super.thana,
    required super.district,
  });

  factory BusinessModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final core = BusinessCoreModel.parse(map: map);
      return BusinessModel(
        identity: core.identity,
        name: core.name,
        urlSlug: core.urlSlug,
        logo: core.logo,
        reviews: core.reviews,
        rating: core.rating,
        verified: core.verified,
        about: map['description'],
        type: map['type'].toString().same(as: 'product') ? ListingType.product : ListingType.business,
        claimed: map['claimed'],
        address: Address(
          street: map['address'],
          thana: core.thana,
          district: core.district,
          division: map['division'],
          latLng: map['latitude'] != null && map['longitude'] != null
              ? LatLng(latitude: map['latitude'], longitude: map['longitude'])
              : null,
        ),
        contact: Contact(
          phone: map['phone'],
          email: map['email'],
          website: map['website'],
        ),
        social: map['socialLink'],
        thana: core.thana,
        district: core.district,
      );
    } catch (e, stackTrace) {
      throw BusinessModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
