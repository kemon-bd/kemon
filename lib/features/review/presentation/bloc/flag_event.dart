part of 'flag_bloc.dart';

sealed class FlagEvent extends Equatable {
  const FlagEvent();

  @override
  List<Object> get props => [];
}

class FlagAbuse extends FlagEvent {
  final Identity review;
  final String? reason;

  const FlagAbuse({required this.review, this.reason});

  @override
  List<Object> get props => [review, reason ?? ''];
}