class UserRegisterModel {
  String? displayName;
  String? email;
  String? token;

  UserRegisterModel({this.displayName, this.email, this.token});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    token = json['token'];
  }
}
