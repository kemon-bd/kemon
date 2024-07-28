part of 'update_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends UpdateProfileEvent {
  final ProfileEntity profile;
  final XFile? avatar;

  const UpdateProfile({
    required this.profile,
    this.avatar,
  });
  @override
  List<Object?> get props => [profile, avatar];
}
