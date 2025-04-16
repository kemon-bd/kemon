import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReactionModel extends ReactionEntity implements UserPreviewEntity, UserPreviewModel {
  const ReactionModel({
    required super.identity,
    required super.name,
    required super.profilePicture,
    required super.type,
  });

  factory ReactionModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final user = UserPreviewModel.parse(map: map);
      return ReactionModel(
        identity: user.identity,
        name: user.name,
        profilePicture: user.profilePicture,
        type: (bool.tryParse(map['type']?.toString() ?? '') ?? false) ? Reaction.like : Reaction.dislike,
      );
    } catch (e, stackTrace) {
      throw ReviewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
