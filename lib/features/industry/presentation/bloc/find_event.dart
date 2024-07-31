part of 'find_bloc.dart';

abstract class FindIndustryEvent extends Equatable {
  const FindIndustryEvent();

  @override
  List<Object> get props => [];
}

class FindIndustry extends FindIndustryEvent {
  final String urlSlug;

  const FindIndustry({
    required this.urlSlug,
  });

  @override
  List<Object> get props => [];
}
