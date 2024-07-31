import '../../../../../core/shared/shared.dart';

class BusinessItemShimmerWidget extends StatelessWidget {
  const BusinessItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final random = Random();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: theme.backgroundPrimary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.backgroundTertiary,
                blurRadius: .25,
                spreadRadius: .25,
              ),
            ],
          ),
          clipBehavior: Clip.none,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0).copyWith(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerLabel(width: 48, height: 48, radius: 8),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLabel(
                              width: 72.0 + random.nextInt(112),
                              height: 12,
                              radius: 8),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ShimmerLabel(
                                  width: 78, height: 12, radius: 8),
                              const SizedBox(width: 16),
                              ShimmerLabel(
                                  width: 64.0 + random.nextInt(64),
                                  height: 8,
                                  radius: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(12.0).copyWith(top: 4, bottom: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShimmerIcon(radius: 16),
                        SizedBox(width: 8),
                        ShimmerIcon(radius: 16),
                        SizedBox(width: 8),
                        ShimmerIcon(radius: 16),
                      ],
                    ),
                    ShimmerLabel(width: 112, height: 12, radius: 8),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
