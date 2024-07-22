part of 'find_bloc.dart';

abstract class FindProfileEvent extends Equatable {
  const FindProfileEvent();

  @override
  List<Object> get props => [];
}

class FindProfile extends FindProfileEvent {
  final Identity identity;

  const FindProfile({
    required this.identity,
  });
  @override
  List<Object> get props => [identity];
}
