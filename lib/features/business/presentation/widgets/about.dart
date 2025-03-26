import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../business.dart';

class BusinessAboutWidget extends StatelessWidget {
  const BusinessAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;

        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              border: Border(
                top: BorderSide(color: theme.textPrimary, width: 1),
              ),
            ),
            child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
              builder: (context, state) {
                if (state is FindBusinessDone) {
                  final business = state.business;
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16).copyWith(
                      bottom: context.bottomInset,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "About ",
                                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                              ),
                              TextSpan(
                                text: business.name.full,
                                style: TextStyles.subTitle(context: context, color: theme.textPrimary)
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              if (business.verified) ...[
                                WidgetSpan(child: SizedBox(width: 8)),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.aboveBaseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: Icon(
                                    Icons.verified_rounded,
                                    color: theme.primary,
                                    size: Dimension.radius.eighteen,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.goNamed(HomePage.name);
                            }
                          },
                          icon: Icon(Icons.close_rounded, color: theme.textPrimary),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxHeight: context.height * .5),
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero.copyWith(bottom: 16),
                          physics: const ScrollPhysics(),
                          children: [
                            HtmlWidget(
                              business.about,
                              textStyle: TextStyles.body(context: context, color: theme.textPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}
