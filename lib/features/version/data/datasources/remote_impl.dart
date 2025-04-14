import '../../../../core/shared/shared.dart';
import '../../../whats_new/whats_new.dart';
import '../../version.dart';

class VersionRemoteDataSourceImpl extends VersionRemoteDataSource {
  final FirebaseRemoteConfig config;

  VersionRemoteDataSourceImpl({
    required this.config,
  });

  @override
  FutureOr<VersionUpdate> find() async {
    try {
       await config.fetch();


      final String version = config.getString('version');
      final String whatsNew = config.getString('whats_new');
      final List<WhatsNewModel> updates = List<dynamic>.from(jsonDecode(whatsNew) ?? [])
          .map(
            (map) => WhatsNewModel.parse(map: map),
          )
          .toList();

      return (version: version, updates: updates);
    } on FirebaseException catch (exception) {
      throw RemoteFailure(message: exception.message ?? 'Something went wrong');
    }
  }
}
