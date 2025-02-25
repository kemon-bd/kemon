part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryState extends Equatable {
  final String query;
  final SortBy? sortBy;

  const FindBusinessesByCategoryState({
    required this.query,
    required this.sortBy,
  });

  @override
  List<Object?> get props => [query, sortBy];
}

class FindBusinessesByCategoryInitial extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryInitial()
      : super(
          query: '',
          sortBy: SortBy.recommended,
        );
}

class FindBusinessesByCategoryLoading extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryLoading({
    required super.query,
    required super.sortBy,
  });
}

class FindBusinessesByCategoryError extends FindBusinessesByCategoryState {
  final Failure failure;

  const FindBusinessesByCategoryError({
    required this.failure,
    required super.query,
    required super.sortBy,
  });

  @override
  List<Object?> get props => [failure, query, sortBy];
}

class FindBusinessesByCategoryDone extends FindBusinessesByCategoryState {
  final int page;
  final int total;
  final List<CategoryEntity> related;
  final List<BusinessEntity> businesses;

  const FindBusinessesByCategoryDone({
    required this.page,
    required super.query,
    required this.total,
    required this.related,
    required this.businesses,
    required super.sortBy,
  });

  @override
  List<Object?> get props => [businesses, total, page, related, query, sortBy];
}

class FindBusinessesByCategoryPaginating extends FindBusinessesByCategoryDone {
  const FindBusinessesByCategoryPaginating({
    required super.page,
    required super.query,
    required super.total,
    required super.related,
    required super.businesses,
    required super.sortBy,
  });

  @override
  List<Object?> get props => [businesses, total, page, related, query, sortBy];
}
