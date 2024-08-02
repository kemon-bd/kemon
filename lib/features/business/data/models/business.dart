import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessModel extends BusinessEntity {
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
  });

  factory BusinessModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('listingGuid') || map.containsKey('guid'),
        'BusinessModel.parse: "listingGuid"/"guid" not found.',
      );
      assert(
        map['listingGuid'] is String || map['guid'] is String,
        'BusinessModel.parse: "listingGuid"/"guid" is not a String.',
      );
      final String guid = map['listingGuid'] ?? map['guid'];

      assert(
        map.containsKey('name'),
        'BusinessModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'BusinessModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      assert(
        map.containsKey('urlslug') || map.containsKey('urlSlug'),
        'BusinessModel.parse: "urlslug"/"urlSlug" not found.',
      );
      assert(
        map['urlslug'] is String || map['urlSlug'] is String,
        'BusinessModel.parse: "urlslug"/"urlSlug" is not a String.',
      );
      final String urlSlug = map['urlslug'] ?? map['urlSlug'];

      assert(
        map.containsKey('icon') || map.containsKey('logo'),
        'BusinessModel.parse: "icon"/"logo" not found.',
      );
      assert(
        map['icon'] is String || map['logo'] is String,
        'BusinessModel.parse: "icon"/"logo" is not a String.',
      );
      final String logo = map['icon'] ?? map['logo'];

      assert(
        map.containsKey('claimed'),
        'BusinessModel.parse: "claimed" not found.',
      );
      assert(
        map['claimed'] is bool?,
        'BusinessModel.parse: "claimed" is not a bool?.',
      );
      final bool? claimed = map['claimed'] as bool?;

      assert(
        map.containsKey('verified'),
        'BusinessModel.parse: "verified" not found.',
      );
      assert(
        map['verified'] is bool?,
        'BusinessModel.parse: "verified" is not a bool?.',
      );
      final bool? verified = map['verified'] as bool?;

      assert(
        map.containsKey('address'),
        'BusinessModel.parse: "address" not found.',
      );
      assert(
        map['address'] is String?,
        'BusinessModel.parse: "address" is not a String?.',
      );
      final String? address = map['address'] as String?;

      assert(
        map.containsKey('phone'),
        'BusinessModel.parse: "phone" not found.',
      );
      assert(
        map['phone'] is String?,
        'BusinessModel.parse: "phone" is not a String?.',
      );
      final String? phone = map['phone'] as String?;

      assert(
        map.containsKey('email'),
        'BusinessModel.parse: "email" not found.',
      );
      assert(
        map['email'] is String?,
        'BusinessModel.parse: "email" is not a String?.',
      );
      final String? email = map['email'] as String?;

      assert(
        map.containsKey('website'),
        'BusinessModel.parse: "website" not found.',
      );
      assert(
        map['website'] is String?,
        'BusinessModel.parse: "website" is not a String?.',
      );
      final String? website = map['website'] as String?;

      assert(
        map.containsKey('listingType'),
        'BusinessModel.parse: "listingType" not found.',
      );
      assert(
        map['listingType'] is String,
        'BusinessModel.parse: "listingType" is not a String.',
      );
      final String type = map['listingType'] as String;

      assert(
        map.containsKey('description'),
        'BusinessModel.parse: "description" not found.',
      );
      assert(
        map['description'] is String?,
        'BusinessModel.parse: "description" is not a String?.',
      );
      final String? description = map['description'];

      return BusinessModel(
        identity: Identity.guid(guid: guid),
        name: Name.full(name: name),
        urlSlug: urlSlug,
        about: description ?? '',
        logo: logo,
        type: type.like(text: 'product') ? ListingType.product : ListingType.business,
        claimed: claimed ?? false,
        verified: verified ?? false,
        address: Address.street(street: address),
        contact: Contact(phone: phone, email: email, website: website),
      );
    } catch (e, stackTrace) {
      throw BusinessModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
