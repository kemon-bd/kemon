import '../shared.dart';

class Contact extends Equatable {
  final String? phone;
  final String? email;
  final String? website;
  final String? name;

  const Contact({
    required this.phone,
    required this.email,
    this.website,
    this.name,
  });

  @override
  List<Object?> get props => [
        phone,
        email,
        website,
        name,
      ];
}
