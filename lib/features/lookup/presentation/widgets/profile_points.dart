import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class ProfilePointsBuilder extends StatelessWidget {
  final Widget Function(List<LookupEntity>) builder;
  const ProfilePointsBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<FindLookupBloc>()..add(FindLookup(lookup: Lookups.profilePoints)),
      child: BlocBuilder<FindLookupBloc, FindLookupState>(
        builder: (context, state) {
          if (state is FindLookupDone) {
            return builder(state.lookups);
          }
          return Container();
        },
      ),
    );
  }
}
