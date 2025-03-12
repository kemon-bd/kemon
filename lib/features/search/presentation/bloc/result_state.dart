part of 'result_bloc.dart';

sealed class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

class SearchResultInitial extends SearchResultState {
  const SearchResultInitial();
  @override
  List<Object> get props => [];
}

class SearchResultLoading extends SearchResultState {
  const SearchResultLoading();
  @override
  List<Object> get props => [];
}

class SearchResultError extends SearchResultState {
  final Failure failure;
  const SearchResultError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

class SearchResultDone extends SearchResultState {
  final List<BusinessLiteEntity> businesses;
  final List<SubCategoryEntity> subCategories;
  final List<LocationEntity> locations;

  const SearchResultDone({
    required this.businesses,
    required this.subCategories,
    required this.locations,
  });

  @override
  List<Object> get props => [businesses, subCategories, locations];
}
