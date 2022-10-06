class User {

  String? userName;
  String? token;

  User({
    this.userName, 
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
    userName: data['username'],
    token: data['token'],
  );

  Map<String, dynamic> toJson() {
    return {
      'username' : userName,
      'token' : token,
    };
  }

  @override
  String toString() {
    return 'UserName: $userName, Token: $token';
  }
}