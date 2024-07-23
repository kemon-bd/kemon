part of 'featured_bloc.dart';

abstract class FeaturedCategoriesState extends Equatable {
  const FeaturedCategoriesState();

  @override
  List<Object> get props => [];
}

class FeaturedCategoriesInitial extends FeaturedCategoriesState {
  const FeaturedCategoriesInitial();
}

class FeaturedCategoriesLoading extends FeaturedCategoriesState {
  const FeaturedCategoriesLoading();
}

class FeaturedCategoriesError extends FeaturedCategoriesState {
  final Failure failure;

  const FeaturedCategoriesError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FeaturedCategoriesDone extends FeaturedCategoriesState {
  final List<CategoryEntity> categories;

  const FeaturedCategoriesDone({required this.categories});

  @override
  List<Object> get props => [categories];
}
