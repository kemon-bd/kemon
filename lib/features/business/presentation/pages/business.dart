import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../business.dart';
import '../../../review/review.dart';

class BusinessPage extends StatelessWidget {
  static const String path = '/review/:urlSlug';
  static const String name = 'BusinessPage';

  final String urlSlug;

  const BusinessPage({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<FindBusinessBloc>().add(RefreshBusiness(urlSlug: urlSlug));
            },
            child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
              builder: (context, state) {
                if (state is FindBusinessLoading) {
                  return BusinessShimmerWidget();
                } else if (state is FindBusinessError) {
                  return Center(child: Text(state.failure.message));
                } else if (state is FindBusinessDone) {
                  return CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: theme.backgroundSecondary,
                        surfaceTintColor: theme.backgroundSecondary,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back_rounded, color: theme.primary),
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.goNamed(HomePage.name);
                            }
                          },
                        ),
                        centerTitle: false,
                        actions: [
                          BusinessShareButton(),
                          IconButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                barrierColor: context.barrierColor,
                                barrierDismissible: true,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<FindBusinessBloc>(),
                                  child: const BusinessAboutWidget(),
                                ),
                              );
                            },
                            icon: Icon(Icons.info_outline_rounded, color: theme.primary, size: 24),
                            iconSize: 24,
                          ),
                        ],
                      ),
                      BusinessInformationWidget(business: state.business),
                      BusinessRatingsWidget(
                        business: state.business,
                        reviews: state.reviews,
                        insights: state.insights,
                        hasMyReview: state.hasMyReview,
                      ),
                      BusinessReviewsWidget(reviews: state.reviews),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }
}
