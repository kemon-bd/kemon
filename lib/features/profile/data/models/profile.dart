import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.identity,
    required super.name,
    required super.phone,
    required super.email,
    required super.dob,
    required super.memberSince,
    required super.gender,
    required super.profilePicture,
    required super.kemonIdentity,
  });

  factory ProfileModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('userId'),
        'ProfileModel.parse: "userId" not found.',
      );
      assert(
        map['userId'] is String,
        'ProfileModel.parse: "userId" is not a String.',
      );
      final String guid = map['userId'] as String;

      assert(
        map.containsKey('firstName'),
        'ProfileModel.parse: "firstName" not found.',
      );
      assert(
        map['firstName'] is String,
        'ProfileModel.parse: "firstName" is not a String.',
      );
      final String firstName = map['firstName'] as String;

      assert(
        map.containsKey('lastName'),
        'ProfileModel.parse: "lastName" not found.',
      );
      assert(
        map['lastName'] is String,
        'ProfileModel.parse: "lastName" is not a String.',
      );
      final String lastName = map['lastName'] as String;

      // assert(
      //   map.containsKey('kemonID'),
      //   'ProfileModel.parse: "kemonID" not found.',
      // );
      assert(
        map['kemonID'] is String?,
        'ProfileModel.parse: "kemonID" is not a String?.',
      );
      final String username = map['kemonID'] ?? '';

      assert(
        map.containsKey('email'),
        'ProfileModel.parse: "email" not found.',
      );
      assert(
        map['email'] is String,
        'ProfileModel.parse: "email" is not a String.',
      );
      final String email = map['email'] as String;

      assert(
        map.containsKey('phone'),
        'ProfileModel.parse: "phone" not found.',
      );
      assert(
        map['phone'] is String,
        'ProfileModel.parse: "phone" is not a String.',
      );
      final String phone = map['phone'] as String;

      assert(
        map.containsKey('profilePicture'),
        'ProfileModel.parse: "profilePicture" not found.',
      );
      assert(
        map['profilePicture'] is String,
        'ProfileModel.parse: "profilePicture" is not a String.',
      );
      final String profilePicture = map['profilePicture'] as String;

      assert(
        map.containsKey('joinDate'),
        'ProfileModel.parse: "joinDate" not found.',
      );
      assert(
        map['joinDate'] is String,
        'ProfileModel.parse: "joinDate" is not a String.',
      );
      final DateTime since = DateTime.parse(map['joinDate']);

      assert(
        map.containsKey('dob'),
        'ProfileModel.parse: "dob" not found.',
      );
      assert(
        map['dob'] is String?,
        'ProfileModel.parse: "dob" is not a String.',
      );
      final DateTime? dob = DateTime.tryParse(map['dob'] ?? '');

      assert(
        map.containsKey('gender'),
        'ProfileModel.parse: "gender" not found.',
      );
      assert(
        map['gender'] is int?,
        'ProfileModel.parse: "gender" is not a int?.',
      );
      final int genderIndex = (map['gender'] as int?) ?? 0;
      final Gender? gender =
          genderIndex.isNegative ? null : Gender.values.elementAt(genderIndex);

      // assert(
      //   map.containsKey('point'),
      //   'ProfileModel.parse: "point" not found.',
      // );
      assert(
        map['point'] is int?,
        'ProfileModel.parse: "point" is not a int?.',
      );
      final int point = (map['point'] as int?) ?? 0;

      // assert(
      //   map.containsKey('referrar'),
      //   'ProfileModel.parse: "referrar" not found.',
      // );
      assert(
        map['referrar'] is String?,
        'ProfileModel.parse: "referrar" is not a String?.',
      );
      final String? referrer = map['referrar'];

      return ProfileModel(
        identity: Identity.guid(guid: guid),
        name: Name(first: firstName, last: lastName),
        memberSince: since,
        phone: phone.isEmpty
            ? null
            : Phone(
                number: phone,
                verified: map['isPhoneVerified'] ?? false,
              ),
        email: email.isEmpty
            ? null
            : Email(
                address: email,
                verified: map['isEmailVerified'] ?? false,
              ),
        profilePicture: profilePicture,
        kemonIdentity: KemonIdentity(
          username: username,
          point: point,
          referrer: referrer,
        ),
        gender: gender,
        dob: dob,
      );
    } catch (e, stackTrace) {
      throw ProfileModelParseFailure(
          message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  List<Object?> get props => [
        identity,
        name,
        phone,
        email,
        dob,
        memberSince,
        gender,
        profilePicture,
      ];
}
