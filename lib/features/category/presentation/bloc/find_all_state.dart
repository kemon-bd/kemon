part of 'find_all_bloc.dart';

abstract class FindAllCategoriesState extends Equatable {
  const FindAllCategoriesState();

  @override
  List<Object?> get props => [];
}

class FindAllCategoriesInitial extends FindAllCategoriesState {
  const FindAllCategoriesInitial() : super();
}

class FindAllCategoriesLoading extends FindAllCategoriesState {
  const FindAllCategoriesLoading();

  @override
  List<Object?> get props => [];
}

class FindAllCategoriesError extends FindAllCategoriesState {
  final Failure failure;

  const FindAllCategoriesError({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

class FindAllCategoriesDone extends FindAllCategoriesState {
  final List<IndustryWithListingCountEntity> industries;

  const FindAllCategoriesDone({
    required this.industries,
  });

  @override
  List<Object?> get props => [industries];
}
