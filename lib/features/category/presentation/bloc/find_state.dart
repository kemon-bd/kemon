part of 'find_bloc.dart';

abstract class FindCategoryState extends Equatable {
  const FindCategoryState();

  @override
  List<Object> get props => [];
}

class FindCategoryInitial extends FindCategoryState {
  const FindCategoryInitial();
}

class FindCategoryLoading extends FindCategoryState {
  const FindCategoryLoading();
}

class FindCategoryError extends FindCategoryState {
  final Failure failure;

  const FindCategoryError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindCategoryDone extends FindCategoryState {
  final CategoryEntity category;

  const FindCategoryDone({required this.category});

  @override
  List<Object> get props => [category];
}
