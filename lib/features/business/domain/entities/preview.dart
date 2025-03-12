import '../../../../core/shared/shared.dart';

class BusinessPreviewEntity extends Equatable {
  final Name name;
  final String urlSlug;
  final String logo;

  const BusinessPreviewEntity({
    required this.name,
    required this.urlSlug,
    required this.logo,
  });

  @override
  List<Object?> get props => [
        name,
        urlSlug,
        logo,
      ];
}
