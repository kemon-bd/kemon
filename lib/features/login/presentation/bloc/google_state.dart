part of 'google_bloc.dart';

sealed class SignInWithGoogleState extends Equatable {
  const SignInWithGoogleState();

  @override
  List<Object> get props => [];
}

final class SignInWithGoogleInitial extends SignInWithGoogleState {}

final class SignInWithGoogleError extends SignInWithGoogleState {
  final Failure failure;

  const SignInWithGoogleError({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class SignInWithGoogleLoading extends SignInWithGoogleState {
  const SignInWithGoogleLoading();
}

final class SignInWithGoogleDone extends SignInWithGoogleState {
  const SignInWithGoogleDone();
}
