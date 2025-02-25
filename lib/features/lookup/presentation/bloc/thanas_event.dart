part of 'thanas_bloc.dart';

abstract class ThanasEvent extends Equatable {
  const ThanasEvent();

  @override
  List<Object> get props => [];
}

class FindThanas extends ThanasEvent {
  final String district;
  const FindThanas({
    required this.district,
  });

  @override
  List<Object> get props => [district];
}