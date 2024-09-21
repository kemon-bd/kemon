import '../../../../core/shared/shared.dart';

class WhatsNewEntity extends Equatable {
  final WhatsNewType type;
  final String title;
  final String? description;

  const WhatsNewEntity({
    required this.type,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        type,
        title,
        description,
      ];
}
