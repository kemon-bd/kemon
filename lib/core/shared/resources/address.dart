import '../shared.dart';

class Address extends Equatable {
  final LatLng? latLng;
  final String? address;
  final String? thana;
  final String? district;
  final String? division;

  const Address({
    required this.latLng,
    required this.address,
    required this.thana,
    required this.district,
    required this.division,
  });

  @override
  List<Object?> get props => [
        latLng,
        address,
        thana,
        district,
        division,
      ];
}
