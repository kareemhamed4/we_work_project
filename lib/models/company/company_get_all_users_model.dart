class CompanyGetAllUsersModel {
  String? token;
  List<Data>? data;

  CompanyGetAllUsersModel({this.token, this.data});

  CompanyGetAllUsersModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? id;
  double? averageRate;
  String? bio;
  String? pictureUrl;
  String? cvUrl;
  String? displayName;
  String? country;
  String? city;
  int? isCompanyOrNot;

  Data(
      {this.id,
        this.bio,
        this.averageRate,
        this.pictureUrl,
        this.cvUrl,
        this.displayName,
        this.country,
        this.city,
        this.isCompanyOrNot});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bio = json['bio'];
    averageRate = json['averageRate'];
    pictureUrl = json['pictureUrl'];
    cvUrl = json['cvUrl'];
    displayName = json['displayName'];
    country = json['country'];
    city = json['city'];
    isCompanyOrNot = json['isCompanyOrNot'];
  }
}
