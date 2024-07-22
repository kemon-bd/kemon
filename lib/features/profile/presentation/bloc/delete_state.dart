part of 'delete_bloc.dart';

abstract class DeleteProfileState extends Equatable {
  const DeleteProfileState();

  @override
  List<Object> get props => [];
}

class DeleteProfileInitial extends DeleteProfileState {
  const DeleteProfileInitial();
}

class DeleteProfileLoading extends DeleteProfileState {
  const DeleteProfileLoading();
}

class DeleteProfileError extends DeleteProfileState {
  final Failure failure;

  const DeleteProfileError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class DeleteProfileDone extends DeleteProfileState {
  const DeleteProfileDone();

  @override
  List<Object> get props => [];
}
