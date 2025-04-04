import 'dart:convert';

import 'package:http/http.dart';

class RemoteResponse<T> {
  final bool success;
  final String? error;
  final T? result;

  RemoteResponse({
    required this.success,
    required this.error,
    required this.result,
  });

  factory RemoteResponse.parse({
    required Response response,
  }) {
    if (response.body.isEmpty) {
      return RemoteResponse._error(error: response.reasonPhrase ?? '');
    }
    final Map<String, dynamic> payload = json.decode(response.body);

    assert(
      payload.containsKey('success'),
      '\'success\' key not found in response',
    );
    assert(
      payload['success'] is bool,
      '\'success\' key must be a boolean',
    );
    final bool success = payload['success'] as bool;

    if (success) {
      assert(
        payload.containsKey('result'),
        '\'result\' key not found in response',
      );
      assert(
        payload['result'] is T,
        '\'result\' key must be of type $T',
      );
      final T? result = payload['result'] as T?;
      return RemoteResponse._success(result: result);
    } else {
      assert(
        payload.containsKey('error'),
        '\'error\' key not found in response',
      );
      assert(
        payload['error'] is String,
        '\'error\' key must be a string',
      );
      final String error = payload['error'] as String;
      return RemoteResponse._error(error: error);
    }
  }

  factory RemoteResponse._error({
    required String error,
  }) {
    return RemoteResponse<T>(
      success: false,
      error: error,
      result: null,
    );
  }

  factory RemoteResponse._success({
    required T? result,
  }) {
    return RemoteResponse<T>(
      success: true,
      error: null,
      result: result,
    );
  }
}
