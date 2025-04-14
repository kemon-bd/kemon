part of 'deeplink_bloc.dart';

sealed class CategoryDeeplinkEvent extends Equatable {
  const CategoryDeeplinkEvent();

  @override
  List<Object> get props => [];
}

final class CategoryDeeplink extends CategoryDeeplinkEvent {
  final String urlSlug;

  const CategoryDeeplink({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
