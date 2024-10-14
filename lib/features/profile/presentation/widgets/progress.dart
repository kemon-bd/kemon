import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class ProfileProgressWidget extends StatelessWidget {
  const ProfileProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FindProfileBloc, FindProfileState>(
          builder: (_, state) {
            if(state is FindProfileDone) {
              final progress = state.profile.progress;
              return LinearProgressIndicator(
                value: progress/100,
                backgroundColor: theme.backgroundSecondary,
                valueColor: AlwaysStoppedAnimation(theme.primary),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
