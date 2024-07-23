part of 'featured_bloc.dart';

sealed class FeaturedCategoriesEvent extends Equatable {
  const FeaturedCategoriesEvent();

  @override
  List<Object> get props => [];
}

class FeaturedCategories extends FeaturedCategoriesEvent {
  const FeaturedCategories();
}
