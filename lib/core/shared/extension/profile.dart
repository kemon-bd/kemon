import '../../../features/profile/profile.dart';

extension ProfileEntityExtension on ProfileEntity {}

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
      "gender": gender.index,
      "point": kemonIdentity.point,
      "referrar": kemonIdentity.referrer,
    };
  }
}
