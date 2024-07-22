part of 'apple_bloc.dart';

sealed class SignInWithAppleState extends Equatable {
  const SignInWithAppleState();

  @override
  List<Object> get props => [];
}

final class SignInWithAppleInitial extends SignInWithAppleState {}

final class SignInWithAppleError extends SignInWithAppleState {
  final Failure failure;

  const SignInWithAppleError({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class SignInWithAppleLoading extends SignInWithAppleState {
  const SignInWithAppleLoading();
}

final class SignInWithAppleDone extends SignInWithAppleState {
  const SignInWithAppleDone();
}
