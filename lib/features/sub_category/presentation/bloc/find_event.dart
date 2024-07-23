part of 'find_bloc.dart';

abstract class FindSubCategoryEvent extends Equatable {
  const FindSubCategoryEvent();

  @override
  List<Object> get props => [];
}

class FindSubCategory extends FindSubCategoryEvent {
  final String urlSlug;

  const FindSubCategory({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
