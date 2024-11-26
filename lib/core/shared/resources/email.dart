import '../shared.dart';

class Email extends Equatable {
  final String address;
  final bool verified;

  const Email({
    required this.address,
    required this.verified,
  });

  @override
  List<Object?> get props => [address, verified];
}
