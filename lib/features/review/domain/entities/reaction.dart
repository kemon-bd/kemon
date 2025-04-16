import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';

class ReactionEntity extends UserPreviewEntity {
  final Reaction type;

  const ReactionEntity({
    required super.identity,
    required super.name,
    required super.profilePicture,
    required this.type,
  });

  @override
  List<Object?> get props => [identity, name, profilePicture, type];
}
