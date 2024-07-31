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
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final DateTime dob;
  final Gender gender;

  const CreateAccount({
    required this.username,
    required this.password,
    required this.refference,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.dob,
    required this.gender,
  });

  @override
  List<Object> get props => [];
}
