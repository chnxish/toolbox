import 'package:dio/dio.dart';

import 'package:toolbox/src/utils/user_preferences.dart';

class TokenInterceptor extends QueuedInterceptor {
  TokenInterceptor({required this.dio});

  final Dio dio;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await UserPreferences.getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Token $token';
    }

    handler.next(options);
  }
}
