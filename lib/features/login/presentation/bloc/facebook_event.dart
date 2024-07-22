part of 'facebook_bloc.dart';

sealed class SignInWithFacebookEvent extends Equatable {
  const SignInWithFacebookEvent();

  @override
  List<Object> get props => [];
}

class SignInWithFacebook extends SignInWithFacebookEvent {
  const SignInWithFacebook();
}
