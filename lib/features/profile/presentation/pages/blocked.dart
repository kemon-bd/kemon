import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../profile.dart';

class BlockedAccountsPage extends StatelessWidget {
  static const String path = '/:user/block-list';
  static const String name = 'BlockedAccountsPage';

  const BlockedAccountsPage({super.key});

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
              icon: Icon(Icons.arrow_back_rounded, color: theme.white),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
            ),
            title: Text("Blocked Accounts"),
            centerTitle: true,
          ),
          body: BlocBuilder<BlockListBloc, BlockListState>(
            builder: (context, state) {
              if (state is BlockListDone) {
                return state.users.isEmpty
                    ? const Center(
                        child: Text("No blocked accounts"),
                      )
                    : ListView.separated(
                        shrinkWrap: false,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.users.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilePicture),
                            ),
                            title: Text(user.name.full),
                            trailing: BlocProvider(
                              create: (context) => sl<UnblockBloc>(),
                              child: BlocConsumer<UnblockBloc, UnblockState>(
                                listener: (context, state) {
                                  if (state is UnblockDone) {
                                    TaskNotifier.instance.success(
                                      context,
                                      message: "${user.name.full} unblocked successfully",
                                    );
                                    context.read<BlockListBloc>().add(const FindBlockList());
                                  } else if (state is UnblockError) {
                                    TaskNotifier.instance.error(context, message: state.failure.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is UnblockLoading) {
                                    return IconButton(
                                      onPressed: () {},
                                      icon: const CircularProgressIndicator(),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => DeleteConfirmationWidget(affirm: "Unblock"),
                                      );
                                      if (!context.mounted) return;
                                      if (confirm ?? false) {
                                        context.read<UnblockBloc>().add(UnblockAbuser(abuser: user.identity));
                                      }
                                    },
                                    icon: Icon(Icons.remove_circle_rounded, size: 24, color: theme.textPrimary),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
              } else if (state is BlockListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            },
          ),
        );
      },
    );
  }
}
