import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class MissingPhoneButton extends StatelessWidget {
  const MissingPhoneButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindProfileBloc, FindProfileState>(
      builder: (context, state) {
        if (state is FindProfileDone) {
          return IconButton(
            padding: EdgeInsets.all(0),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onPressed: () async {
              final edited = await context.pushNamed<bool>(EditProfilePage.name);

              if (!(edited ?? false)) return;
              if (!context.mounted) return;
              context.read<FindProfileBloc>().add(RefreshProfile(identity: context.auth.profile!.identity));
            },
            icon: Icon(Icons.help_rounded, color: theme.link, size: 20),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
