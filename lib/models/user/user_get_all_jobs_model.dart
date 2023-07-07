class UserGetAllJobsModel {
  int? count;
  String? token;
  List<Data>? data;

  UserGetAllJobsModel({this.count, this.token, this.data});

  UserGetAllJobsModel.fromJson(Map<String, dynamic> json) {
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
  bool? hasApplied;
  String? pictureUrl;
  String? description;
  String? city;
  String? category;
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
        this.category,
        this.country,
        this.salary,
        this.appUserId,
        this.hasApplied,
        this.user,
        this.isCompanyOrNot});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    hasApplied = json['hasApplied'];
    pictureUrl = json['pictureUrl'];
    description = json['description'];
    city = json['city'];
    category = json['category'];
    country = json['country'];
    salary = json['salary'];
    appUserId = json['appUserId'];
    user = json['user'];
    isCompanyOrNot = json['isCompanyOrNot'];
  }
}
