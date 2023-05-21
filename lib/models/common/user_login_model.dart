class UserLoginModel {
  bool? isCompany;
  String? token;

  UserLoginModel({this.isCompany, this.token});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    isCompany = json['isCompany'];
    token = json['token'];
  }
}
