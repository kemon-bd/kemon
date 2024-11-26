import '../../../../core/shared/shared.dart';
import '../../review.dart';

class ReactionModel extends ReactionEntity {
  const ReactionModel({
    required super.user,
    required super.type,
  });

  factory ReactionModel.parse({
    required Map<String, dynamic> map,
  }) {
    final user = Identity.guid(guid: map["userGuid"]);
    final type = Reaction.values.elementAt(map["type"] ?? 0);
    return ReactionModel(
      user: user,
      type: type,
    );
  }

  @override
  List<Object?> get props => [user, type];
}
