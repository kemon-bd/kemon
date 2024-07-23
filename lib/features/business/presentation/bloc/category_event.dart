part of 'category_bloc.dart';

abstract class BusinessesByCategoryEvent extends Equatable {
  const BusinessesByCategoryEvent();

  @override
  List<Object> get props => [];
}

class BusinessesByCategory extends BusinessesByCategoryEvent {
  final String category;

  const BusinessesByCategory({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}
