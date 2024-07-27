import '../../../../core/shared/shared.dart';

class BusinessEntity extends Equatable {
  final Identity identity;
  final Name name;
  final String urlSlug;
  final String about;
  final String logo;
  final ListingType type;
  final bool claimed;
  final bool verified;
  final Address address;
  final Contact contact;

  const BusinessEntity({
    required this.identity,
    required this.name,
    required this.urlSlug,
    required this.about,
    required this.logo,
    required this.type,
    required this.claimed,
    required this.verified,
    required this.address,
    required this.contact,
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
      ];
}
