import '../../../../core/shared/shared.dart';

class ReactionEntity extends Equatable {
  final Identity user;
  final Reaction type;

  const ReactionEntity({
    required this.user,
    required this.type,
  });

  @override
  List<Object?> get props => [user, type];
}
