import '../shared.dart';

class KemonIdentity extends Equatable {
  final int point;
  final String username;
  final String? referrer;

  const KemonIdentity({
    required this.point,
    required this.username,
    required this.referrer,
  });

  @override
  List<Object?> get props => [point, username, referrer];
}
