part of 'deeplink_bloc.dart';

sealed class CategoryDeeplinkState extends Equatable {
  const CategoryDeeplinkState();

  @override
  List<Object> get props => [];
}

final class CategoryDeeplinkInitial extends CategoryDeeplinkState {}

final class CategoryDeeplinkLoading extends CategoryDeeplinkState {}

final class CategoryDeeplinkError extends CategoryDeeplinkState {
  final Failure failure;

  const CategoryDeeplinkError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

final class CategoryDeeplinkDone extends CategoryDeeplinkState {
  final CategoryEntity category;

  const CategoryDeeplinkDone({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}
