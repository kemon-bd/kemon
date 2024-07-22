import '../../../../core/shared/shared.dart';

class TokenEntity extends Equatable {
  final String token;
  final DateTime expires;

  const TokenEntity({
    required this.token,
    required this.expires,
  });

  @override
  List<Object?> get props => [
        token,
        expires,
      ];
}
