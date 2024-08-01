import '../shared.dart';

class DropdownLoadingWidget extends StatelessWidget {
  final String label;
  final EdgeInsets? padding;
  final TextStyle? labelStyle;

  const DropdownLoadingWidget({
    super.key,
    required this.label,
    this.padding,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final labelWidget = Text(
          label,
          style: labelStyle ??
              TextStyles.subTitle(context: context, color: theme.textSecondary),
        );
        const textWidget = ShimmerLabel(width: 72, height: 12, radius: 8);
        return Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelWidget,
              textWidget,
            ],
          ),
        );
      },
    );
  }
}
