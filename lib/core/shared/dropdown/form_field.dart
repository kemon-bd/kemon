import '../shared.dart';

class DropdownFormWidget<T> extends DropdownWidget<T> {
  final FormFieldValidator<T> validator;
  final Widget? icon;
  const DropdownFormWidget({
    super.key,
    required super.label,
    required super.text,
    required super.onSelect,
    required super.popup,
    required this.validator,
    this.icon,
    super.labelStyle,
    super.textStyle,
    super.padding,
  }) : assert(popup != null && onSelect != null);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (validator) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (_, state) {
          final theme = state.scheme;

          final bool valid = !validator.hasError && validator.isValid;

          final labelWidget = Text(
            label,
            style: labelStyle ??
                context.text.bodyMedium?.copyWith(
                  color: theme.textSecondary,
                  fontWeight: FontWeight.normal,
                ),
          );
          final textWidget = Text(
            text,
            style: textStyle?.copyWith(color: valid ? theme.textPrimary : theme.negative) ??
                TextStyles.overline(context: context, color: valid ? theme.textPrimary : theme.negative),
            maxLines: 1,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          );
          final iconWidget = icon ?? Icon(Icons.arrow_drop_down_rounded, size: 20, color: theme.textPrimary);
          return InkWell(
            onTap: () async {
              final selection = await showModalBottomSheet<T?>(
                context: context,
                isDismissible: false,
                isScrollControlled: true,
                barrierColor: context.barrierColor,
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .85),
                builder: (_) => popup!,
              );

              if (selection != null) {
                onSelect!(selection);
              }
            },
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  labelWidget,
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: textWidget,
                        ),
                        if (valid) iconWidget,
                        if (!valid) const SizedBox(width: 4),
                        if (!valid)
                          Icon(Icons.error_rounded, size: 20, color: theme.negative)
                              .animate(
                                onComplete: (controller) => controller.repeat(reverse: true),
                              )
                              .fade(duration: const Duration(seconds: 1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
