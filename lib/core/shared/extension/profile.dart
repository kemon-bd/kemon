import '../../../features/profile/profile.dart';
import '../shared.dart';

extension ProfileEntityExtension on ProfileEntity {
  int get progress {
    int p = 0;
    if (name.full.isNotEmpty) {
      p += 30;
    }
    if ((contact.email ?? '').isNotEmpty) {
      p += 20;
    }
    if ((contact.phone ?? '').isNotEmpty) {
      p += 20;
    }
    if (gender != null) {
      p += 10;
    }
    if (dob != null) {
      p += 10;
    }
    if ((profilePicture ?? '').isNotEmpty) {
      p += 10;
    }
    return p;
  }
}

extension ProfileModelExtension on ProfileModel {
  Map<String, dynamic> get toMap {
    return {
      "userId": identity.guid,
      "firstName": name.first,
      "lastName": name.last,
      "kemonID": kemonIdentity.username,
      "email": contact.email,
      "phone": contact.phone,
      "profilePicture": profilePicture,
      "joinDate": memberSince.toIso8601String(),
      "dob": dob?.toIso8601String(),
      "gender": gender?.index ?? -1,
      "point": kemonIdentity.point,
      "referrar": kemonIdentity.referrer,
    };
  }

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    DateTime? dob,
    Gender? gender,
  }) {
    return ProfileModel(
      identity: identity,
      name: Name(
        first: firstName ?? name.first,
        last: lastName ?? name.last,
      ),
      contact: Contact(
        email: email ?? contact.email,
        phone: phone ?? contact.phone,
      ),
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      kemonIdentity: kemonIdentity,
      profilePicture: profilePicture,
      memberSince: memberSince,
    );
  }
}
