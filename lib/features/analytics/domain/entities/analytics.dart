import '../../../../core/shared/shared.dart';

class AnalyticsEntity extends Equatable {
  final Identity identity;

  const AnalyticsEntity({
    required this.identity,
  });

  @override
  List<Object?> get props => [
        identity,
      ];
}
