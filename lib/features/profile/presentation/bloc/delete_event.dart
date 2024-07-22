part of 'delete_bloc.dart';

abstract class DeleteProfileEvent extends Equatable {
  const DeleteProfileEvent();

  @override
  List<Object> get props => [];
}

class DeleteProfile extends DeleteProfileEvent {
  final Identity identity;

  const DeleteProfile({
    required this.identity,
  });
  @override
  List<Object> get props => [identity];
}
