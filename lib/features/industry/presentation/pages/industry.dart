import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../industry.dart';

class IndustryPage extends StatelessWidget {
  static const String path = '/industry/:urlSlug';
  static const String name = 'IndustryPage';

  final String urlSlug;
  const IndustryPage({
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
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: theme.primary,
            surfaceTintColor: theme.primary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.backgroundPrimary),
              onPressed: context.pop,
            ),
            title: BlocBuilder<FindIndustryBloc, FindIndustryState>(
              builder: (context, state) {
                if (state is FindIndustryDone) {
                  final industry = state.industry;
                  return Text(
                    industry.name.full,
                    style: TextStyles.title(context: context, color: theme.backgroundPrimary).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                  );
                }
                return Container();
              },
            ),
            centerTitle: false,
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: BoxDecoration(color: theme.primary),
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
                  builder: (context, state) {
                    if (state is FindBusinessesByCategoryLoading) {
                      return Center(
                        child: ShimmerLabel(width: context.width * .55, height: 39, radius: 12),
                      );
                    }
                    return Center(
                      child: BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
                        builder: (context, state) {
                          if (state is FindBusinessesByCategoryDone) {
                            final int businesses = state.businesses
                                .where(
                                  (element) => element.type == ListingType.business,
                                )
                                .length;
                            final int products = state.businesses
                                .where(
                                  (element) => element.type == ListingType.product,
                                )
                                .length;

                            final bool business = state.type == ListingType.business;
                            return CupertinoSlidingSegmentedControl<bool>(
                              groupValue: business,
                              children: {
                                true: Text(
                                  "$businesses Business${businesses > 1 ? 'es' : ''}",
                                  style: TextStyles.subTitle(
                                    context: context,
                                    color: business ? theme.primary : theme.textPrimary,
                                  ).copyWith(
                                    fontWeight: business ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                false: Text(
                                  "$products Product${products > 1 ? 'es' : ''}",
                                  style: TextStyles.subTitle(
                                    context: context,
                                    color: !business ? theme.primary : theme.textPrimary,
                                  ).copyWith(
                                    fontWeight: !business ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              },
                              onValueChanged: (business) {
                                context.read<FindBusinessesByCategoryBloc>().add(
                                      ToggleListingType(type: business! ? ListingType.business : ListingType.product),
                                    );
                              },
                              thumbColor: theme.backgroundPrimary,
                              padding: const EdgeInsets.all(6.0),
                              backgroundColor: theme.backgroundPrimary.withAlpha(25),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
                builder: (context, state) {
                  if (state is FindBusinessesByCategoryLoading) {
                    return ListView.separated(
                      cacheExtent: double.maxFinite,
                      itemBuilder: (_, index) {
                        return const BusinessItemShimmerWidget();
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    );
                  } else if (state is FindBusinessesByCategoryDone) {
                    final businesses = state.businesses.where((element) => element.type == state.type).toList();
                    return businesses.isNotEmpty
                        ? ListView.separated(
                            cacheExtent: double.maxFinite,
                            itemBuilder: (_, index) {
                              final business = businesses[index];
                              return BusinessItemWidget(urlSlug: business.urlSlug);
                            },
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemCount: businesses.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          )
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: context.height * .25),
                              child: Text(
                                "No ${state.type == ListingType.business ? 'business' : 'product'} found :(",
                                style: TextStyles.title(context: context, color: theme.backgroundTertiary),
                              ),
                            ),
                          );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
