import '../../../../core/shared/shared.dart';
import '../../review.dart';

class ReactionsSheet extends StatelessWidget {
  const ReactionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindReviewReactionsBloc, FindReviewReactionsState>(
      builder: (context, state) {
        if (state is FindReviewReactionsDone) {
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0).copyWith(bottom: 16 + context.bottomInset),
            separatorBuilder: (_, index) => const Divider(height: 1),
            itemBuilder: (_, index) {
              final reaction = state.reactions[index];
              final liked = reaction.type == Reaction.like;
              return ListTile(
                leading: SizedBox.square(
                  dimension: 36,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.backgroundSecondary,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: reaction.profilePicture.url,
                          fit: BoxFit.cover,
                          width: 36,
                          height: 36,
                        ),
                      ),
                      Positioned(
                        bottom: -6,
                        right: -8,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: liked ? theme.primary : theme.negative,
                            border: Border.all(
                              color: theme.backgroundPrimary,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            liked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.solidThumbsDown,
                            size: 12,
                            color: theme.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  reaction.name.full,
                  style: context.text.bodyMedium?.copyWith(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            itemCount: state.reactions.length,
          );
        } else if (state is FindReviewReactionsError) {
          return Center(
            child: Text(
              state.failure.message,
              style: context.text.bodyMedium?.copyWith(
                color: theme.negative,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
