import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessNameWidget extends StatelessWidget {
  final TextStyle? style;
  final TextAlign? align;
  final Alignment? shimmerAlignment;
  final VoidCallback? onTap;

  const BusinessNameWidget({
    super.key,
    this.style,
    this.align,
    this.shimmerAlignment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FindBusinessBloc, FindBusinessState>(
          builder: (context, state) {
            if (state is FindBusinessDone) {
              return InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(12),
                child: Text(
                  state.business.name.full,
                  style: style ??
                      TextStyles.subTitle(
                          context: context, color: theme.textPrimary),
                  textAlign: align,
                ),
              );
            } else if (state is FindBusinessLoading) {
              return Align(
                alignment: shimmerAlignment ?? Alignment.centerLeft,
                child: const ShimmerLabel(width: 112, height: 12, radius: 12),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
