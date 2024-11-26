import '../../../../core/shared/shared.dart';

class ProfileEntity extends Equatable {
  final Identity identity;
  final Name name;
  final Phone? phone;
  final Email? email;
  final DateTime? dob;
  final DateTime memberSince;
  final String? profilePicture;
  final Gender? gender;
  final KemonIdentity kemonIdentity;

  const ProfileEntity({
    required this.identity,
    required this.name,
    required this.phone,
    required this.email,
    required this.dob,
    required this.memberSince,
    required this.gender,
    required this.profilePicture,
    required this.kemonIdentity,
  });

  @override
  List<Object?> get props => [
        identity,
        name,
        phone,
        email,
        dob,
        profilePicture,
        gender,
        memberSince,
        kemonIdentity,
      ];
}
