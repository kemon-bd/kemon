import '../shared.dart';
import '../../../features/lookup/lookup.dart';
import '../../../features/profile/profile.dart';

extension ProfileEntityExtension on ProfileEntity {
  int progress({
    required List<LookupEntity> checks,
  }) {
    int p = 0;
    if (name.full.isNotEmpty) {
      p += checks.firstWhereOrNull((c) => c.name)?.point ?? 0;
    }
    if ((email?.address ?? '').isNotEmpty) {
      p += checks.firstWhereOrNull((c) => c.email)?.point ?? 0;
    }
    if (email?.verified ?? false) {
      p += checks.firstWhereOrNull((c) => c.emailVerified)?.point ?? 0;
    }
    if ((phone?.number ?? '').isNotEmpty) {
      p += checks.firstWhereOrNull((c) => c.phone)?.point ?? 0;
    }
    if (phone?.verified ?? false) {
      p += checks.firstWhereOrNull((c) => c.phoneVerified)?.point ?? 0;
    }
    if (gender != null) {
      p += checks.firstWhereOrNull((c) => c.gender)?.point ?? 0;
    }
    if (dob != null) {
      p += checks.firstWhereOrNull((c) => c.dob)?.point ?? 0;
    }
    if ((profilePicture ?? '').isNotEmpty) {
      p += checks.firstWhereOrNull((c) => c.profilePicture)?.point ?? 0;
    }
    return p;
  }

  List<LookupEntity> missing({
    required List<LookupEntity> checks,
  }) {
    final List<LookupEntity> missing = [...checks].toList();

    if (name.full.isNotEmpty) {
      missing.removeWhere((c) => c.name);
    }
    if ((email?.address ?? '').isNotEmpty) {
      missing.removeWhere((c) => c.email);
    }
    if (email?.verified ?? false) {
      missing.removeWhere((c) => c.emailVerified);
    }
    if ((phone?.number ?? '').isNotEmpty) {
      missing.removeWhere((c) => c.phone);
    }
    if (phone?.verified ?? false) {
      missing.removeWhere((c) => c.phoneVerified);
    }
    if (gender != null) {
      missing.removeWhere((c) => c.gender);
    }
    if (dob != null) {
      missing.removeWhere((c) => c.dob);
    }
    if ((profilePicture ?? '').isNotEmpty) {
      missing.removeWhere((c) => c.profilePicture);
    }
    return missing;
  }
}

extension ProfileModelExtension on ProfileModel {
  Map<String, dynamic> get toMap {
    return {
      "userId": identity.guid,
      "firstName": name.first,
      "lastName": name.last,
      "kemonID": kemonIdentity.username,
      "email": email?.address,
      "phone": phone?.number,
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
      phone: Phone(
        number: phone ?? this.phone?.number ?? '',
        verified: this.phone?.verified ?? false,
      ),
      email: Email(
        address: email ?? this.email?.address ?? '',
        verified: this.email?.verified ?? false,
      ),
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      kemonIdentity: kemonIdentity,
      profilePicture: profilePicture,
      memberSince: memberSince,
    );
  }
}
