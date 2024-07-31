part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {
  const OtpInitial();
}

final class OtpError extends OtpState {
  final Failure failure;

  const OtpError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

final class OtpLoading extends OtpState {
  const OtpLoading();
}

final class OtpDone extends OtpState {
  final String code;

  const OtpDone({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}
