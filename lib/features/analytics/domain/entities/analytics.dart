import '../../../../core/shared/shared.dart';

class AnalyticsEntity extends Equatable {
  // TODO: implement entity properties
  final Identity identity;

  AnalyticsEntity({
    required this.identity,
  });

  @override
  List<Object?> get props => [
        // TODO: add entity properties
        identity,
      ];
}
