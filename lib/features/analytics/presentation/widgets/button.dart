import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../analytics.dart';

class AnalyticsButton extends StatelessWidget {
  final Widget Function(
    SyncAnalyticsBloc bloc,
  ) child;
  const AnalyticsButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = sl<SyncAnalyticsBloc>();
    return BlocProvider(
      create: (_) => bloc,
      child: child(bloc),
    );
  }
}
