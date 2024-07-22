part of 'find_bloc.dart';

abstract class FindProfileState extends Equatable {
  const FindProfileState();

  @override
  List<Object> get props => [];
}

class FindProfileInitial extends FindProfileState {
  const FindProfileInitial();
}

class FindProfileLoading extends FindProfileState {
  const FindProfileLoading();
}

class FindProfileError extends FindProfileState {
  final Failure failure;

  const FindProfileError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindProfileDone extends FindProfileState {
  final ProfileEntity profile;

  const FindProfileDone({required this.profile});

  @override
  List<Object> get props => [profile];
}
