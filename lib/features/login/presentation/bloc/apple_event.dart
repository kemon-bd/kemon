part of 'apple_bloc.dart';

sealed class SignInWithAppleEvent extends Equatable {
  const SignInWithAppleEvent();

  @override
  List<Object> get props => [];
}

class AppleSignIn extends SignInWithAppleEvent {
  const AppleSignIn();
}
