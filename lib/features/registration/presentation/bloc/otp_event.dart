part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class ResendOtp extends OtpEvent {
  final String username;

  const ResendOtp({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}
