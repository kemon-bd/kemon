import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../home/home.dart';
import '../../search.dart';

class ResultPage extends StatefulWidget {
  static const String path = '/search/result';
  static const String name = 'ResultPage';

  final String query;

  const ResultPage({
    super.key,
    required this.query,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            backgroundColor: theme.backgroundPrimary,
            surfaceTintColor: theme.backgroundPrimary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
            ),
            title: Text(widget.query),
            titleTextStyle: TextStyles.subTitle(context: context, color: theme.textPrimary),
            centerTitle: false,
            actions: const [
              /* IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(),
                    builder: (_) => BlocProvider.value(
                      value: context.read<SearchResultBloc>(),
                      child: const _FilterOption(),
                    ),
                  );
                },
              ), */
            ],
          ),
          body: BlocBuilder<SearchResultBloc, SearchResultState>(
            builder: (context, state) {
              if (state is SearchResultLoading) {
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
              } else if (state is SearchResultDone) {
                final businesses = state.businesses;
                return ListView.separated(
                  cacheExtent: double.maxFinite,
                  itemBuilder: (_, index) {
                    final business = businesses[index];
                    return BusinessItemWidget(business: business);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: businesses.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero.copyWith(bottom: context.bottomInset + 16),
                );
              } else if (state is SearchResultError) {
                return Center(
                  child: Text(state.failure.message),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
