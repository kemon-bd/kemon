import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationDeepLinkPage extends StatelessWidget {
  static const String path = '/deeplink/location/:urlSlug';
  static const String name = 'LocationDeepLinkPage';
  final String urlSlug;
  const LocationDeepLinkPage({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationDeeplinkBloc, LocationDeeplinkState>(
      listener: (context, state) {
        if (state is LocationDeeplinkDone) {
          if (state.location is DivisionEntity) {
            final division = state.location as DivisionEntity;
            context.goNamed(
              DivisionPage.name,
              pathParameters: {
                'division': division.urlSlug,
              },
            );
          } else if (state.location is DistrictEntity) {
            final district = state.location as DistrictEntity;
            context.goNamed(
              DistrictPage.name,
              pathParameters: {
                'division': district.division,
                'district': district.urlSlug,
              },
            );
          } else {
            final thana = state.location as ThanaEntity;
            context.goNamed(
              ThanaPage.name,
              pathParameters: {
                'division': thana.division,
                'district': thana.district,
                'thana': thana.urlSlug,
              },
            );
          }
        }
      },
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}
