import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReviewMenuAlert extends StatelessWidget {
  final ListingReviewEntity review;
  const ReviewMenuAlert({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return AlertDialog(
          backgroundColor: theme.backgroundPrimary,
          clipBehavior: Clip.antiAlias,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Action",
                style: context.text.headlineSmall?.copyWith(
                  color: theme.textPrimary,
                  fontWeight: FontWeight.bold,
                  inherit: true,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: context.pop,
                icon: Icon(Icons.close_rounded, color: theme.textPrimary),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12, right: 8),
          contentPadding: const EdgeInsets.all(0).copyWith(bottom: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(thickness: .5, height: 8),
              if (review.myReview(me: context.auth.identity?.guid ?? "")) ...[
                ListTile(
                  onTap: () async {
                    final edited = await context.pushNamed<bool>(
                      EditReviewPage.name,
                      pathParameters: {
                        "urlSlug": context.business.urlSlug,
                      },
                      extra: review.convertToUserBasedReview(context: context),
                    );

                    if (!context.mounted) return;
                    if (edited ?? false) {
                      context.pop(true);
                      context.successNotification(message: "Review updated successfully.");
                    }
                  },
                  leading: Icon(Icons.edit_outlined, color: theme.textPrimary),
                  title: Text(
                    "Edit",
                    style: context.text.bodyLarge?.copyWith(
                      color: theme.textPrimary,
                      fontWeight: FontWeight.bold,
                      inherit: true,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (context) => sl<DeleteReviewBloc>(),
                  child: BlocConsumer<DeleteReviewBloc, DeleteReviewState>(
                    listener: (context, state) {
                      if (state is DeleteReviewDone) {
                        context.pop(true);
                        context.successNotification(message: "Review deleted successfully.");
                      }
                    },
                    builder: (blockContext, state) {
                      if (state is DeleteReviewLoading) {
                        return ListTile(
                          leading: Icon(Icons.circle, size: 24, color: theme.backgroundSecondary),
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 112,
                              height: 12,
                              decoration: BoxDecoration(
                                color: theme.backgroundSecondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      }
                      return ListTile(
                        onTap: () async {
                          final confirm = await showDialog<bool>(
                            context: blockContext,
                            builder: (_) => DeleteConfirmationWidget(affirm: "Confirm"),
                          );
                          if (!blockContext.mounted) return;
                          if (confirm ?? false) {
                            blockContext.read<DeleteReviewBloc>().add(DeleteReview(review: review.identity));
                          }
                        },
                        leading: Icon(Icons.delete_outlined, color: theme.negative),
                        title: Text(
                          "Delete",
                          style: context.text.bodyLarge?.copyWith(
                            color: theme.negative,
                            fontWeight: FontWeight.bold,
                            inherit: true,
                          ),
                        ),
                        subtitle: state is DeleteReviewError
                            ? Text(
                                state.failure.message,
                                style: context.text.bodySmall?.copyWith(
                                  color: theme.negative,
                                  inherit: true,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
              if (!review.myReview(me: context.auth.identity?.guid ?? "")) ...[
                BlocProvider(
                  create: (context) => sl<FlagBloc>(),
                  child: BlocConsumer<FlagBloc, FlagState>(
                    listener: (context, state) {
                      if (state is FlagDone) {
                        context.pop(true);
                        TaskNotifier.instance.success(context, message: "Review flagged successfully");
                      }
                    },
                    builder: (flagContext, state) {
                      if (state is FlagLoading) {
                        return ListTile(
                          leading: Icon(Icons.circle, size: 24, color: theme.backgroundSecondary),
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 112,
                              height: 12,
                              decoration: BoxDecoration(
                                color: theme.backgroundPrimary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      }
                      return ListTile(
                        onTap: () async {
                          final currentUser = flagContext.auth.profile;

                          final confirm = await showDialog<bool>(
                            context: flagContext,
                            builder: (_) => DeleteConfirmationWidget(affirm: "Flag"),
                          );

                          if (!flagContext.mounted) return;
                          if (confirm ?? false) {
                            final user = currentUser ??
                                await flagContext.pushNamed<ProfileEntity>(
                                  CheckProfilePage.name,
                                  queryParameters: {"authorize": "true"},
                                );

                            if (!flagContext.mounted) return;
                            if (user != null) {
                              final reason = await showDialog<LookupEntity>(
                                context: flagContext,
                                builder: (_) => const FlagReasonFilter(selection: null),
                              );
                              if (!flagContext.mounted) return;
                              flagContext.read<FlagBloc>().add(FlagAbuse(review: review.identity, reason: reason?.text ?? ""));
                            }
                          }
                        },
                        leading: Icon(Icons.flag_outlined, color: theme.textPrimary),
                        title: Text(
                          "Flag as Inappropriate",
                          style: context.text.bodyLarge?.copyWith(
                            color: theme.textPrimary,
                            fontWeight: FontWeight.bold,
                            inherit: true,
                          ),
                        ),
                        subtitle: state is FlagError
                            ? Text(
                                state.failure.message,
                                style: context.text.bodySmall?.copyWith(
                                  color: theme.negative,
                                  inherit: true,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
                BlocProvider(
                  create: (context) => sl<BlockBloc>(),
                  child: BlocConsumer<BlockBloc, BlockState>(
                    listener: (context, state) {
                      if (state is BlockDone) {
                        context.goNamed(
                          BlockedAccountsPage.name,
                          pathParameters: {
                            "user": context.auth.identity?.guid ?? "",
                          },
                        );
                        context.warningNotification(message: "${review.reviewer.name.full} is blocked successfully");
                      }
                    },
                    builder: (blockContext, state) {
                      if (state is BlockLoading) {
                        return ListTile(
                          leading: Icon(Icons.circle, size: 24, color: theme.backgroundSecondary),
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 112,
                              height: 12,
                              decoration: BoxDecoration(
                                color: theme.backgroundSecondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      }
                      return ListTile(
                        onTap: () async {
                          final currentUser = blockContext.auth.profile;
                          final confirm = await showDialog<bool>(
                            context: blockContext,
                            builder: (_) => DeleteConfirmationWidget(affirm: "Block"),
                          );
                          if (!blockContext.mounted) return;
                          if (confirm ?? false) {
                            final user = currentUser ??
                                await blockContext.pushNamed<ProfileEntity>(
                                  CheckProfilePage.name,
                                  queryParameters: {"authorize": "true"},
                                );

                            if (!blockContext.mounted) return;
                            if (user != null) {
                              final reason = await showDialog<LookupEntity>(
                                context: blockContext,
                                builder: (_) => const BlockReasonFilter(selection: null),
                              );
                              if (!blockContext.mounted) return;
                              blockContext
                                  .read<BlockBloc>()
                                  .add(BlockAbuser(abuser: review.reviewer.identity, reason: reason?.text ?? ""));
                            }
                          }
                        },
                        leading: const Icon(Icons.block_rounded, color: Colors.purple),
                        title: Text(
                          "Block '${review.reviewer.name.full}'",
                          style: context.text.bodyLarge?.copyWith(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            inherit: true,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: state is BlockError
                            ? Text(
                                state.failure.message,
                                style: context.text.bodySmall?.copyWith(
                                  color: theme.negative,
                                  inherit: true,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
