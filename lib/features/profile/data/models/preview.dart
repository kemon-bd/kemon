import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class UserPreviewModel extends UserPreviewEntity {
  const UserPreviewModel({
    required super.identity,
    required super.name,
    required super.profilePicture,
  });

  factory UserPreviewModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('guid'),
        'UserPreviewModel.parse: "guid" not found.',
      );
      assert(
        map['guid'] is String,
        'UserPreviewModel.parse: "guid" is not a String.',
      );
      final String guid = map['guid'] as String;

      assert(
        map.containsKey('name'),
        'UserPreviewModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'UserPreviewModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      assert(
        map.containsKey('profilePicture'),
        'UserPreviewModel.parse: "profilePicture" not found.',
      );
      assert(
        map['profilePicture'] is String?,
        'UserPreviewModel.parse: "profilePicture" is not a String?.',
      );
      final String profilePicture = (map['profilePicture'] as String?) ?? '';

      return UserPreviewModel(
        identity: Identity.guid(guid: guid),
        name: Name.full(name: name),
        profilePicture: profilePicture,
      );
    } catch (e, stackTrace) {
      throw ProfileModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
