class Token {
  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresIn,
    required this.refreshTokenExpiresIn,
  });

  String accessToken;
  String refreshToken;
  String accessTokenExpiresIn;
  String refreshTokenExpiresIn;

  factory Token.empty() {
    return Token(
      accessToken: '',
      refreshToken: '',
      accessTokenExpiresIn: '',
      refreshTokenExpiresIn: '',
    );
  }

  Token.fromJson(Map<String, dynamic> json)
      : accessToken = json['access'] as String,
        refreshToken = json['refresh'] as String,
        accessTokenExpiresIn = json['access_expires_in'] as String,
        refreshTokenExpiresIn = json['refresh_expires_in'] as String;

  Map<String, dynamic> toJson() => {
        'access': accessToken,
        'refresh': refreshToken,
        'access_expires_in': accessTokenExpiresIn,
        'refresh_expires_in': refreshTokenExpiresIn,
      };

  @override
  String toString() {
    return 'Token: $accessToken';
  }
}
