part of 'forgot_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPassword extends ForgotPasswordEvent {
  final String username;
  
  const ForgotPassword({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}
