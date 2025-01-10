part of 'fb_login_bloc.dart';

sealed class FacebookLoginEvent extends Equatable {
  const FacebookLoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginWithFacebook extends FacebookLoginEvent {}