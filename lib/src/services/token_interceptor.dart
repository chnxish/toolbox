import 'package:dio/dio.dart';

import 'package:toolbox/src/constant/service_url.dart';
import 'package:toolbox/src/services/dio_service.dart';
import 'package:toolbox/src/utils/exceptions.dart';
import 'package:toolbox/src/utils/token_preferences.dart';
import 'package:toolbox/src/utils/user_preferences.dart';

class TokenInterceptor extends QueuedInterceptor {
  TokenInterceptor({required this.dio});

  final Dio dio;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = await TokenPreferences.getAccessToken();
    if (accessToken.isNotEmpty) {
      var accessTokenValidityTime =
          await TokenPreferences.getAccessTokenValidityTime();
      if (accessTokenValidityTime < 60) {
        var refreshTokenValidityTime =
            await TokenPreferences.getRefreshTokenValidityTime();
        if (refreshTokenValidityTime < 60) {
          TokenPreferences.clear();
          UserPreferences.clear();
          throw NavigationException('Go to login');
        }
        FormData params = FormData.fromMap(
            {'refresh': await TokenPreferences.getRefreshToken()});
        DioService.post(ServiceUrl.refresh, params, successCallBack: (data) {
          String accessToken = data['access'];
          String accessTokenExpiresIn = data['access_expires_in'];
          TokenPreferences.setAccessToken(accessToken);
          TokenPreferences.setAccessTokenExpiresIn(accessTokenExpiresIn);
        });
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }
}
