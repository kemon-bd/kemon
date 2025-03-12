import '../shared.dart';

abstract class NetworkInfo {
  Future<bool> get online;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker checker;

  NetworkInfoImpl({
    required this.checker,
  });

  @override
  Future<bool> get online => checker.hasConnection;
}
