class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.avatar,
  });

  int id;
  String username;
  String email;
  String password;
  String avatar;

  factory User.empty() {
    return User(
      id: 0,
      username: '',
      email: '',
      password: '',
      avatar: '',
    );
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        username = json['username'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        avatar = json['avatar'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'avatar': avatar,
      };

  @override
  String toString() {
    return 'Username: $username';
  }
}
