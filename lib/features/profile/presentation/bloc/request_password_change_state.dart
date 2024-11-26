part of 'request_password_change_bloc.dart';

sealed class RequestOtpForPasswordChangeState extends Equatable {
  const RequestOtpForPasswordChangeState();

  @override
  List<Object> get props => [];
}

final class RequestOtpForPasswordChangeInitial extends RequestOtpForPasswordChangeState {
  const RequestOtpForPasswordChangeInitial();
  @override
  List<Object> get props => [];
}

final class RequestOtpForPasswordChangeError extends RequestOtpForPasswordChangeState {
  final Failure failure;

  const RequestOtpForPasswordChangeError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

final class RequestOtpForPasswordChangeLoading extends RequestOtpForPasswordChangeState {
  const RequestOtpForPasswordChangeLoading();
  @override
  List<Object> get props => [];
}

final class RequestOtpForPasswordChangeDone extends RequestOtpForPasswordChangeState {
  final String otp;

  const RequestOtpForPasswordChangeDone({
    required this.otp,
  });
  @override
  List<Object> get props => [otp];
}
