part of 'check_bloc.dart';

abstract class CheckProfileEvent extends Equatable {
  const CheckProfileEvent();

  @override
  List<Object> get props => [];
}

class CheckProfile extends CheckProfileEvent {
  final String username;

  const CheckProfile({
    required this.username,
  });
  @override
  List<Object> get props => [username];
}
