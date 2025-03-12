import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';

class BusinessRatingWidget extends StatelessWidget {
  final String urlSlug;
  const BusinessRatingWidget({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return BlocBuilder<FindBusinessBloc, FindBusinessState>(
          builder: (context, state) {
            if (state is FindBusinessDone) {
              return Row(
                children: [
                  RatingBarIndicator(
                    rating: state.business.rating,
                    itemBuilder: (context, index) => Icon(Icons.stars_rounded, color: theme.primary),
                    unratedColor: theme.backgroundSecondary,
                    itemCount: 5,
                    itemSize: 16,
                    direction: Axis.horizontal,
                  ),
                  if (state.business.reviews > 0) ...[
                    const SizedBox(width: 4),
                    Text(
                      state.business.rating.toStringAsFixed(1),
                      style: TextStyles.caption(context: context, color: theme.textSecondary),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.circle, color: theme.backgroundSecondary, size: 4),
                    const SizedBox(width: 8),
                    Text(
                      '${state.business.reviews.toString()} review${state.business.reviews > 1 ? 's' : ''}',
                      style: TextStyles.caption(context: context, color: theme.textSecondary),
                    ),
                  ]
                ],
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
