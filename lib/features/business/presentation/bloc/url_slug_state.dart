part of 'url_slug_bloc.dart';

sealed class ValidateUrlSlugState extends Equatable {
  const ValidateUrlSlugState();

  @override
  List<Object> get props => [];
}

final class ValidateUrlSlugInitial extends ValidateUrlSlugState {}

final class ValidateUrlSlugLoading extends ValidateUrlSlugState {}

final class ValidateUrlSlugError extends ValidateUrlSlugState {
  final Failure failure;

  const ValidateUrlSlugError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

final class ValidateUrlSlugDone extends ValidateUrlSlugState {}
