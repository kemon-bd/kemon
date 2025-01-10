part of 'google_sign_in_bloc.dart';

sealed class GoogleSignInState extends Equatable {
  const GoogleSignInState();

  @override
  List<Object> get props => [];
}

final class GoogleSignInInitial extends GoogleSignInState {}

final class GoogleSignInError extends GoogleSignInState {
  final Failure failure;
  const GoogleSignInError({required this.failure});
}

final class GoogleSignInLoading extends GoogleSignInState {}

final class GoogleSignInDone extends GoogleSignInState {
  final ProfileEntity profile;
  const GoogleSignInDone({required this.profile});
}
