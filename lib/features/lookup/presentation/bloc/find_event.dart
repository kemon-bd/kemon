part of 'find_bloc.dart';

abstract class FindLookupEvent extends Equatable {
  const FindLookupEvent();

  @override
  List<Object> get props => [];
}

class FindLookup extends FindLookupEvent {
  final Lookups lookup;

  const FindLookup({
    required this.lookup,
  });
  @override
  List<Object> get props => [lookup];
}

class FindLookupWithParent extends FindLookupEvent {
  final Lookups lookup;
  final String parent;

  const FindLookupWithParent({
    required this.lookup,
    required this.parent,
  });
  @override
  List<Object> get props => [lookup, parent];
}

class SearchLookup extends FindLookupEvent {
  final Lookups lookup;
  final String query;

  const SearchLookup({
    required this.lookup,
    required this.query,
  });
  @override
  List<Object> get props => [lookup, query];
}

class SearchLookupWithParent extends FindLookupEvent {
  final Lookups lookup;
  final String query;
  final String parent;

  const SearchLookupWithParent({
    required this.lookup,
    required this.query,
    required this.parent,
  });
  @override
  List<Object> get props => [lookup, parent, query];
}
