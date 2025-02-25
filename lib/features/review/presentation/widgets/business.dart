import '../../../../core/shared/shared.dart';
import '../../review.dart';

class BusinessReviewsWidget extends StatelessWidget {
  const BusinessReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindListingReviewsBloc, FindListingReviewsState>(
      builder: (context, state) {
        if (state is FindListingReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FindListingReviewsError) {
          return Center(child: Text(state.failure.message));
        } else if (state is FindListingReviewsDone) {
          final List<ReviewEntity> reviews = state.reviews.filter(options: state.filter);

          return ListView.separated(
            itemBuilder: (_, index) {
              final review = reviews[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                clipBehavior: Clip.antiAlias,
                child: SmoothHighlight(
                  useInitialHighLight: true,
                  duration: 3.seconds,
                  enabled: review.identity.guid.same(as: state.guid),
                  color: Colors.yellowAccent.shade700,
                  padding: EdgeInsets.all(2),
                  child: BusinessReviewItemWidget(review: review),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 16 + context.bottomInset),
            shrinkWrap: true,
          );
        }
        return const SizedBox();
      },
    );
  }
}
