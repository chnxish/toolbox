import 'package:toolbox/src/utils/sp_util.dart';

class TokenPreferences {
  static const String _spAccessToken = 'accessToken';
  static const String _spRefreshToken = 'refreshToken';
  static const String _spAccessTokenExpiresIn = 'accessTokenExpiresIn';
  static const String _spRefreshTokenExpiresIn = 'refreshTokenExpiresIn';

  static Future<String> getAccessToken() async {
    return SpUtil.getString(_spAccessToken);
  }

  static Future<void> setAccessToken(String accessToken) async {
    SpUtil.setString(_spAccessToken, accessToken);
  }

  static Future<String> getRefreshToken() async {
    return SpUtil.getString(_spRefreshToken);
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    SpUtil.setString(_spRefreshToken, refreshToken);
  }

  static Future<String> getAccessTokenExpiresIn() async {
    return SpUtil.getString(_spAccessTokenExpiresIn);
  }

  static Future<void> setAccessTokenExpiresIn(
      String accessTokenExpiresIn) async {
    SpUtil.setString(_spAccessTokenExpiresIn, accessTokenExpiresIn);
  }

  static Future<String> getRefreshTokenExpiresIn() async {
    return SpUtil.getString(_spRefreshTokenExpiresIn);
  }

  static Future<void> setRefreshTokenExpiresIn(
      String refreshTokenExpiresIn) async {
    SpUtil.setString(_spRefreshTokenExpiresIn, refreshTokenExpiresIn);
  }

  static Future<int> getAccessTokenValidityTime() async {
    String accessTokenExpiresIn = SpUtil.getString(_spAccessTokenExpiresIn);
    DateTime parsedDate = DateTime.parse(accessTokenExpiresIn);
    return parsedDate.difference(DateTime.now()).inSeconds;
  }

  static Future<int> getRefreshTokenValidityTime() async {
    String refreshTokenExpiresIn = SpUtil.getString(_spRefreshTokenExpiresIn);
    DateTime parsedDate = DateTime.parse(refreshTokenExpiresIn);
    return parsedDate.difference(DateTime.now()).inSeconds;
  }

  static Future<void> clear() async {
    SpUtil.remove(_spAccessToken);
    SpUtil.remove(_spRefreshToken);
    SpUtil.remove(_spAccessTokenExpiresIn);
    SpUtil.remove(_spRefreshTokenExpiresIn);
  }
}
