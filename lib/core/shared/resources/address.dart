import '../shared.dart';

class Address extends Equatable {
  final LatLng? latLng;
  final String? street;
  final String? thana;
  final String? district;
  final String? division;

  const Address({
    required this.latLng,
    required this.street,
    required this.thana,
    required this.district,
    required this.division,
  });

  factory Address.street({
    required String? street,
  }) {
    return Address(
      latLng: null,
      street: street,
      thana: null,
      district: null,
      division: null,
    );
  }

  @override
  List<Object?> get props => [
        latLng,
        street,
        thana,
        district,
        division,
      ];
}
