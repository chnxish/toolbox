import 'package:flutter/material.dart';

import 'package:toolbox/src/models/token.dart';
import 'package:toolbox/src/utils/token_preferences.dart';

class TokenProvider extends ChangeNotifier {
  TokenProvider() {
    getPreferences();
  }

  Token _token = Token.empty();

  String get accessToken => _token.accessToken;
  String get refreshToken => _token.refreshToken;
  String get accessTokenExpiresIn => _token.accessTokenExpiresIn;
  String get refreshTokenExpiresIn => _token.refreshTokenExpiresIn;

  set accessToken(String value) {
    _token.accessToken = value;
    TokenPreferences.setAccessToken(value);
    notifyListeners();
  }

  set refreshToken(String value) {
    _token.refreshToken = value;
    TokenPreferences.setRefreshToken(value);
    notifyListeners();
  }

  set accessTokenExpiresIn(String value) {
    _token.accessTokenExpiresIn = value;
    TokenPreferences.setAccessTokenExpiresIn(value);
    notifyListeners();
  }

  set refreshTokenExpiresIn(String value) {
    _token.refreshTokenExpiresIn = value;
    TokenPreferences.setRefreshTokenExpiresIn(value);
    notifyListeners();
  }

  set token(Token token) {
    _token = token;
    TokenPreferences.setAccessToken(token.accessToken);
    TokenPreferences.setRefreshToken(token.refreshToken);
    TokenPreferences.setAccessTokenExpiresIn(token.accessTokenExpiresIn);
    TokenPreferences.setRefreshTokenExpiresIn(token.refreshTokenExpiresIn);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    final accessToken = await TokenPreferences.getAccessToken();
    final refreshToken = await TokenPreferences.getRefreshToken();
    final accessTokenExpiresIn =
        await TokenPreferences.getAccessTokenExpiresIn();
    final refreshTokenExpiresIn =
        await TokenPreferences.getRefreshTokenExpiresIn();

    _token = Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
      accessTokenExpiresIn: accessTokenExpiresIn,
      refreshTokenExpiresIn: refreshTokenExpiresIn,
    );
    notifyListeners();
  }
}
