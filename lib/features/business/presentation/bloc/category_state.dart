part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryState extends Equatable {
  const FindBusinessesByCategoryState();

  @override
  List<Object> get props => [];
}

class FindBusinessesByCategoryInitial extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryInitial();
}

class FindBusinessesByCategoryLoading extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryLoading();
}

class FindBusinessesByCategoryError extends FindBusinessesByCategoryState {
  final Failure failure;

  const FindBusinessesByCategoryError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindBusinessesByCategoryDone extends FindBusinessesByCategoryState {
  final int page;
  final int total;
  final List<CategoryEntity> related;
  final List<BusinessEntity> businesses;

  const FindBusinessesByCategoryDone({
    required this.page,
    required this.total,
    required this.related,
    required this.businesses,
  });

  @override
  List<Object> get props => [businesses, total, page, related];
}

class FindBusinessesByCategoryPaginating extends FindBusinessesByCategoryDone {
  const FindBusinessesByCategoryPaginating({
    required super.page,
    required super.total,
    required super.related,
    required super.businesses,
  });

  @override
  List<Object> get props => [businesses, total, page, related];
}
