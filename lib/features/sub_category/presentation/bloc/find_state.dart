part of 'find_bloc.dart';

abstract class FindSubCategoryState extends Equatable {
  const FindSubCategoryState();

  @override
  List<Object> get props => [];
}

class FindSubCategoryInitial extends FindSubCategoryState {
  const FindSubCategoryInitial();
}

class FindSubCategoryLoading extends FindSubCategoryState {
  const FindSubCategoryLoading();
}

class FindSubCategoryError extends FindSubCategoryState {
  final Failure failure;

  const FindSubCategoryError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindSubCategoryDone extends FindSubCategoryState {
  final SubCategoryEntity subCategory;

  const FindSubCategoryDone({required this.subCategory});

  @override
  List<Object> get props => [subCategory];
}
