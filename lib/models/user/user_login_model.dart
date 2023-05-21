/*
class UserLoginModel {
  int? count;
  String? token;
  List<Data>? data;

  UserLoginModel({this.count, this.token, this.data});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
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
  int? id;
  String? title;
  String? pictureUrl;
  String? description;
  String? city;
  String? country;
  int? salary;
  String? appUserId;
  String? user;
  int? isCompanyOrNot;

  Data(
      {this.id,
        this.title,
        this.pictureUrl,
        this.description,
        this.city,
        this.country,
        this.salary,
        this.appUserId,
        this.user,
        this.isCompanyOrNot});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    pictureUrl = json['pictureUrl'];
    description = json['description'];
    city = json['city'];
    country = json['country'];
    salary = json['salary'];
    appUserId = json['appUserId'];
    user = json['user'];
    isCompanyOrNot = json['isCompanyOrNot'];
  }
}*/
