import '../shared.dart';

class Phone extends Equatable {
  final String number;
  final bool verified;

  const Phone({
    required this.number,
    required this.verified,
  });

  @override
  List<Object?> get props => [number, verified];
}
