part of 'find_bloc.dart';

abstract class FindCategoryEvent extends Equatable {
  const FindCategoryEvent();

  @override
  List<Object> get props => [];
}

class FindCategory extends FindCategoryEvent {
  final String urlSlug;

  const FindCategory({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
