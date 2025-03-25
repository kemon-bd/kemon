part of 'apple_login_bloc.dart';


sealed class AppleLoginState extends Equatable {
  const AppleLoginState();

  @override
  List<Object> get props => [];
}

final class AppleLoginInitial extends AppleLoginState {}

final class AppleLoginError extends AppleLoginState {
  final Failure failure;

  const AppleLoginError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class AppleLoginLoading extends AppleLoginState {}

final class AppleLoginDone extends AppleLoginState {
  final ProfileEntity profile;

  const AppleLoginDone({required this.profile});

  @override
  List<Object> get props => [profile];
}
