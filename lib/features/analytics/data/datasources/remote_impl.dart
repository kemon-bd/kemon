import '../../../../core/shared/shared.dart';
import '../../analytics.dart';

class AnalyticsRemoteDataSourceImpl extends AnalyticsRemoteDataSource {
  final Client client;

  AnalyticsRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<void> sync({
    required AnalyticSource source,
    required String referrer,
    required Identity listing,
    required Identity? user,
  }) async {
    final PackageInfo package = await PackageInfo.fromPlatform();
    final DeviceInfoPlugin device = DeviceInfoPlugin();
    String ip = '';

    if (Platform.isAndroid) {
      final AndroidDeviceInfo android = await device.androidInfo;
      ip = "${android.brand} ${android.model} | ${android.id}";
    } else if (Platform.isIOS) {
      final IosDeviceInfo ios = await device.iosInfo;
      ip = "${ios.name} ${ios.systemName}-${ios.systemVersion} | ${ios.identifierForVendor}";
    }

    final Map<String, String> headers = {
      'analyticsType': source.dataKey,
      'listingGuid': listing.guid,
      'userId': user?.guid ?? '',
      'referrer': referrer,
      'ip': ip,
      'userAgent': 'App ${package.version}+${package.buildNumber}',
    };

    final Response response = await client.post(
      RemoteEndpoints.analytics,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<void> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return;
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }
}
