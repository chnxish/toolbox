class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.avatar,
    required this.token,
  });

  String id;
  String username;
  String email;
  String password;
  String avatar;
  String token;

  factory User.empty() {
    return User(
      id: '',
      username: '',
      email: '',
      password: '',
      avatar: '',
      token: '',
    );
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        username = json['username'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        avatar = json['avatar'] as String,
        token = json['token'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'avatar': avatar,
        'token': token,
      };

  @override
  String toString() {
    return 'Username: $username';
  }
}
