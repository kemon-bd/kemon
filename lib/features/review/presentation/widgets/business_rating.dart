import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../review.dart';

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
        return BlocProvider(
          create: (context) =>
              sl<FindRatingBloc>()..add(FindRating(urlSlug: urlSlug)),
          child: BlocBuilder<FindRatingBloc, FindRatingState>(
            builder: (context, state) {
              if (state is FindRatingDone) {
                return Row(
                  children: [
                    RatingBarIndicator(
                      rating: state.rating.average,
                      itemBuilder: (context, index) =>
                          Icon(Icons.star_rounded, color: theme.primary),
                      unratedColor: theme.backgroundTertiary,
                      itemCount: 5,
                      itemSize: 16,
                      direction: Axis.horizontal,
                    ),
                    if (state.rating.total > 0) ...[
                      const SizedBox(width: 4),
                      Text(
                        '${state.rating.average}',
                        style: TextStyles.caption(
                            context: context, color: theme.textSecondary),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.circle,
                          color: theme.backgroundSecondary, size: 4),
                      const SizedBox(width: 8),
                      Text(
                        '${state.rating.total.toString()} review${state.rating.total > 1 ? 's' : ''}',
                        style: TextStyles.caption(
                            context: context, color: theme.textSecondary),
                      ),
                    ]
                  ],
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
