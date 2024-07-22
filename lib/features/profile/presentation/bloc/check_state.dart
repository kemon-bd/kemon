part of 'check_bloc.dart';

abstract class CheckProfileState extends Equatable {
  const CheckProfileState();

  @override
  List<Object> get props => [];
}

class CheckProfileInitial extends CheckProfileState {
  const CheckProfileInitial();
}

class CheckProfileLoading extends CheckProfileState {
  const CheckProfileLoading();
}

class CheckProfileError extends CheckProfileState {
  final Failure failure;

  const CheckProfileError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class CheckProfileExistingUser extends CheckProfileState {
  final ProfileEntity profile;

  const CheckProfileExistingUser({required this.profile});

  @override
  List<Object> get props => [profile];
}

class CheckProfileNewUser extends CheckProfileState {
  final String otp;

  const CheckProfileNewUser({required this.otp});

  @override
  List<Object> get props => [otp];
}
