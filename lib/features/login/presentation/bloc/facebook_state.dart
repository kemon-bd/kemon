part of 'facebook_bloc.dart';

sealed class SignInWithFacebookState extends Equatable {
  const SignInWithFacebookState();

  @override
  List<Object> get props => [];
}

final class SignInWithFacebookInitial extends SignInWithFacebookState {}

final class SignInWithFacebookError extends SignInWithFacebookState {
  final Failure failure;

  const SignInWithFacebookError({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class SignInWithFacebookLoading extends SignInWithFacebookState {
  const SignInWithFacebookLoading();
}

final class SignInWithFacebookDone extends SignInWithFacebookState {
  const SignInWithFacebookDone();
}
