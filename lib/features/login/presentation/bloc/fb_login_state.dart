part of 'fb_login_bloc.dart';

sealed class FacebookLoginState extends Equatable {
  const FacebookLoginState();

  @override
  List<Object> get props => [];
}

final class FacebookLoginInitial extends FacebookLoginState {}

final class FacebookLoginError extends FacebookLoginState {
  final Failure failure;

  const FacebookLoginError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class FacebookLoginLoading extends FacebookLoginState {}

final class FacebookLoginDone extends FacebookLoginState {
  final ProfileEntity profile;

  const FacebookLoginDone({required this.profile});

  @override
  List<Object> get props => [profile];
}
