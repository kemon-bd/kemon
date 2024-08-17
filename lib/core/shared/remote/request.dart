import '../shared.dart';

class RemoteRequest {
  final Client client;

  RemoteRequest({
    required this.client,
  });

  final Map<String, Completer<Response>> _cache = {};

  Future<Response> get({
    required Uri url,
    Map<String, String>? headers,
  }) async {
    final key = _generateKey(
      url: url,
      headers: headers,
    );

    if (_cache.containsKey(key)) {
      return _cache[key]!.future;
    } else {
      final completer = Completer<Response>();
      _cache[key] = completer;

      try {
        final response = await client.get(url, headers: headers);
        completer.complete(response);
      } catch (e) {
        completer.completeError(e);
      } finally {
        _cache.remove(key);
      }

      return completer.future;
    }
  }

  Future<Response> post({
    required Uri url,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final key = _generateKey(
      url: url,
      headers: headers,
    );

    if (_cache.containsKey(key)) {
      return _cache[key]!.future;
    } else {
      final completer = Completer<Response>();
      _cache[key] = completer;

      try {
        final response = await client.post(url, headers: headers, body: body);
        completer.complete(response);
      } catch (e) {
        completer.completeError(e);
      } finally {
        _cache.remove(key);
      }

      return completer.future;
    }
  }

  Future<Response> delete({
    required Uri url,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final key = _generateKey(
      url: url,
      headers: headers,
    );

    if (_cache.containsKey(key)) {
      return _cache[key]!.future;
    } else {
      final completer = Completer<Response>();
      _cache[key] = completer;

      try {
        final response = await client.delete(url, headers: headers, body: body);
        completer.complete(response);
      } catch (e) {
        completer.completeError(e);
      } finally {
        _cache.remove(key);
      }

      return completer.future;
    }
  }

  String _generateKey({
    required Uri url,
    Map<String, String>? headers,
    dynamic body,
  }) =>
      '$url${headers?.toString() ?? ''}${body?.toString() ?? ''}';
}
