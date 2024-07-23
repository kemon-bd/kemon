part of 'category_bloc.dart';

abstract class SubCategoriesByCategoryState extends Equatable {
  const SubCategoriesByCategoryState();

  @override
  List<Object> get props => [];
}

class SubCategoriesByCategoryInitial extends SubCategoriesByCategoryState {
  const SubCategoriesByCategoryInitial();
}

class SubCategoriesByCategoryLoading extends SubCategoriesByCategoryState {
  const SubCategoriesByCategoryLoading();
}

class SubCategoriesByCategoryError extends SubCategoriesByCategoryState {
  final Failure failure;

  const SubCategoriesByCategoryError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class SubCategoriesByCategoryDone extends SubCategoriesByCategoryState {
  final List<SubCategoryEntity> subCategories;

  const SubCategoriesByCategoryDone({required this.subCategories});

  @override
  List<Object> get props => [subCategories];
}
