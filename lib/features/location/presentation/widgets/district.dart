import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';

class DistrictFilterWidget extends StatefulWidget {
  final String division;
  final LookupEntity? district;

  const DistrictFilterWidget({
    super.key,
    required this.district,
    required this.division,
  });

  @override
  State<DistrictFilterWidget> createState() => _DistrictFilterWidgetState();
}

class _DistrictFilterWidgetState extends State<DistrictFilterWidget> {
  final TextEditingController controller = TextEditingController();
  LookupEntity? district;

  @override
  void initState() {
    super.initState();
    district = widget.district;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.viewInsets,
      child: Material(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final theme = state.scheme;
            return Container(
              decoration: BoxDecoration(
                color: theme.backgroundPrimary,
                border: Border(
                  top: BorderSide(color: theme.textPrimary, width: 1),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16).copyWith(bottom: context.bottomInset + 16),
                physics: const ScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "District",
                        style: TextStyles.headline(context: context, color: theme.textPrimary),
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: theme.textPrimary,
                          size: 24,
                          weight: 400,
                          grade: 200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<FindLookupBloc, FindLookupState>(
                    builder: (districtContext, state) {
                      if (state is FindLookupDone) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: [
                            TextField(
                              controller: controller,
                              onChanged: (value) {
                                districtContext.read<FindLookupBloc>().add(
                                      SearchLookupWithParent(
                                        query: value,
                                        lookup: Lookups.district,
                                        parent: widget.division,
                                      ),
                                    );
                              },
                              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.backgroundSecondary,
                                hintText: "Search district ...",
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.clear();
                                    districtContext.read<FindLookupBloc>().add(
                                          FindLookupWithParent(
                                            lookup: Lookups.district,
                                            parent: widget.division,
                                          ),
                                        );
                                  },
                                  child: Icon(
                                    Icons.cancel_rounded,
                                    color: theme.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            PhysicalModel(
                              color: theme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(16),
                              child: state.lookups.isNotEmpty
                                  ? ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(height: .25, color: theme.backgroundTertiary),
                                      itemBuilder: (context, index) {
                                        final place = state.lookups[index];
                                        final bool selected = place.value.same(as: widget.district?.value);

                                        return InkWell(
                                          onTap: () {
                                            context.pop(place);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                                                  color: selected ? theme.positive : theme.textPrimary,
                                                  size: 24,
                                                  grade: 200,
                                                  weight: 700,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    place.text,
                                                    style: TextStyles.subTitle(
                                                      context: context,
                                                      color: selected ? theme.positive : theme.textPrimary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.lookups.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero.copyWith(top: 8, bottom: 8),
                                      physics: const NeverScrollableScrollPhysics(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "No district found",
                                        style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
