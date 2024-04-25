class RegisterRequestModel {
  String? username;
  String? email;
  String? password;

  RegisterRequestModel({this.username, this.email, this.password});

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'email': email,
      'password': password,
    };
    return data;
  }
}
