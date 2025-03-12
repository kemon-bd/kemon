import '../../../../core/shared/shared.dart';
import '../../review.dart';

class BusinessReviewsWidget extends StatelessWidget {
  final List<ListingReviewEntity> reviews;
  const BusinessReviewsWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 16 + context.bottomInset),
      sliver: SliverList.separated(
        itemBuilder: (_, index) {
          final review = reviews[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            clipBehavior: Clip.antiAlias,
            child: BusinessReviewItemWidget(review: review),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: reviews.length,
      ),
    );
  }
}
