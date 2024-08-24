part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class CreateAccount extends RegistrationEvent {
  final String username;
  final String password;
  final String refference;

  const CreateAccount({
    required this.username,
    required this.password,
    required this.refference,
  });

  @override
  List<Object> get props => [];
}
