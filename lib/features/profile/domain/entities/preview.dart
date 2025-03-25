import '../../../../core/shared/shared.dart';

class UserPreviewEntity extends Equatable {
  final Identity identity;
  final Name name;
  final String profilePicture;

  const UserPreviewEntity({
    required this.identity,
    required this.name,
    required this.profilePicture,
  });
  @override
  List<Object> get props => [identity, name, profilePicture];
}
