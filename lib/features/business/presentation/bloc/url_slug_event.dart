part of 'url_slug_bloc.dart';

sealed class ValidateUrlSlugEvent extends Equatable {
  const ValidateUrlSlugEvent();

  @override
  List<Object> get props => [];
}

class ValidateUrlSlug extends ValidateUrlSlugEvent {
  final String urlSlug;

  const ValidateUrlSlug({
    required this.urlSlug,
  });

  @override
  List<Object> get props => [urlSlug];
}