import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessClaimWidget extends StatelessWidget {
  const BusinessClaimWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;

        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              border: Border(
                top: BorderSide(color: theme.textPrimary, width: 1),
              ),
            ),
            child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
              builder: (context, state) {
                if (state is FindBusinessDone) {
                  final business = state.business;
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16).copyWith(
                      bottom: 16 + context.bottomInset,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        trailing: IconButton(
                          onPressed: context.pop,
                          icon: Icon(Icons.close_rounded,
                              color: theme.textPrimary),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Icon(
                        business.claimed
                            ? Icons.admin_panel_settings_rounded
                            : Icons.privacy_tip_outlined,
                        color: business.claimed
                            ? theme.primary
                            : theme.textSecondary.withAlpha(100),
                        size: 144,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'This business is ${business.claimed ? 'already claimed by the owner' : 'not claimed yet'}.',
                        style: TextStyles.body(
                            context: context, color: theme.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}
