part of 'google_bloc.dart';

sealed class SignInWithGoogleEvent extends Equatable {
  const SignInWithGoogleEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogle extends SignInWithGoogleEvent {
  const SignInWithGoogle();
}
