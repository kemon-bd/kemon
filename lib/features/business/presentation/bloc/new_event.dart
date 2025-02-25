part of 'new_bloc.dart';

sealed class NewListingEvent extends Equatable {
  const NewListingEvent();

  @override
  List<Object?> get props => [];
}

final class PublishNewListing extends NewListingEvent {
  final String name;
  final String urlSlug;
  final String about;

  final XFile? logo;
  final ListingType type;

  final String phone;
  final String email;
  final String website;
  final String social;

  final IndustryEntity industry;
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;

  final String address;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;

  const PublishNewListing({
    required this.name,
    required this.urlSlug,
    required this.about,
    required this.logo,
    required this.type,
    required this.phone,
    required this.email,
    required this.website,
    required this.social,
    required this.industry,
    required this.category,
    required this.subCategory,
    required this.address,
    required this.division,
    required this.district,
    required this.thana,
  });

  @override
  List<Object?> get props => [
        name,
        urlSlug,
        about,
        logo,
        type,
        phone,
        email,
        website,
        social,
        industry,
        category,
        subCategory,
        address,
        division,
        district,
        thana,
      ];
}
