part of 'find_all_bloc.dart';

abstract class FindAllCategoriesEvent extends Equatable {
  const FindAllCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class FindAllCategories extends FindAllCategoriesEvent {
  final String? query;
  const FindAllCategories({
    this.query,
  });
  @override
  List<Object?> get props => [query];
}


class RefreshAllCategories extends FindAllCategoriesEvent {
  const RefreshAllCategories();
  @override
  List<Object?> get props => [];
}
