import '../../../../core/shared/shared.dart';

class LookupEntity extends Equatable {
  final String text;
  final String value;

  const LookupEntity({
    required this.text,
    required this.value,
  });

  @override
  List<Object> get props => [text, value];
}
