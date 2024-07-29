import '../../../../../core/shared/shared.dart';

class DashboardFeaturedLocationsSectionShimmerWidget extends StatelessWidget {
  const DashboardFeaturedLocationsSectionShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return ListView(
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          children: [
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShimmerLabel(width: 160, height: 18),
                ShimmerLabel(width: 84, height: 10),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 140,
              child: MasonryGridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 0,
                padding: EdgeInsets.zero,
                itemCount: 9,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final salt = Random().nextInt(72);
                  return ActionChip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(width: 1, color: theme.backgroundTertiary),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: theme.backgroundSecondary,
                    onPressed: () {},
                    avatar: const ShimmerIcon(radius: 20),
                    label: ShimmerLabel(
                      width: 72.0 + salt,
                      height: 12.0,
                      radius: 100,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
