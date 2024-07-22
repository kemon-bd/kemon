import '../shared.dart';

class LatLng extends Equatable {
  final double latitude;
  final double longitude;

  const LatLng({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
