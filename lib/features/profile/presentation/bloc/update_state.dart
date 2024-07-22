part of 'update_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {
  const UpdateProfileInitial();
}

class UpdateProfileLoading extends UpdateProfileState {
  const UpdateProfileLoading();
}

class UpdateProfileError extends UpdateProfileState {
  final Failure failure;

  const UpdateProfileError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class UpdateProfileDone extends UpdateProfileState {
  const UpdateProfileDone();

  @override
  List<Object> get props => [];
}
