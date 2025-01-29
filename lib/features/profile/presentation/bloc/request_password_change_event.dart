part of 'request_password_change_bloc.dart';

sealed class RequestOtpForPasswordChangeEvent extends Equatable {
  const RequestOtpForPasswordChangeEvent();

  @override
  List<Object> get props => [];
}

final class RequestOtpForPasswordChange
    extends RequestOtpForPasswordChangeEvent {
  final String username;

  const RequestOtpForPasswordChange({
    required this.username,
  });
  @override
  List<Object> get props => [username];
}
final class RequestOtpForPhoneOrEmailVerification
    extends RequestOtpForPasswordChangeEvent {
  final String username;

  const RequestOtpForPhoneOrEmailVerification({
    required this.username,
  });
  @override
  List<Object> get props => [username];
}
