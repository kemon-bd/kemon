import '../shared.dart';

class Name extends Equatable {
  final String first;
  final String last;

  const Name({
    required this.first,
    required this.last,
  });

  factory Name.full({
    required String name,
  }) {
    final List<String> names = name.split(' ');
    final String lastName = names.last;
    names.removeLast();
    final String firstName = names.join(' ');
    return Name(
      first: firstName.trim(),
      last: lastName.trim(),
    );
  }

  @override
  List<Object?> get props => [first, last];
}
