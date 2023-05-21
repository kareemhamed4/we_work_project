class CompanyGetJobsModel {
  int? id;
  String? workPlace;
  String? pictureUrl;
  String? title;
  String? description;
  String? position;
  String? jobType;
  String? requirement;
  String? created;
  String? city;
  String? country;
  String? skill;
  int? salary;
  String? experience;
  String? user;
  String? userId;

  CompanyGetJobsModel(
      {this.id,
        this.workPlace,
        this.pictureUrl,
        this.title,
        this.description,
        this.position,
        this.jobType,
        this.requirement,
        this.created,
        this.city,
        this.country,
        this.skill,
        this.salary,
        this.experience,
        this.user,
        this.userId});

  CompanyGetJobsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workPlace = json['workPlace'];
    pictureUrl = json['pictureUrl'];
    title = json['title'];
    description = json['description'];
    position = json['position'];
    jobType = json['jobType'];
    requirement = json['requirement'];
    created = json['created'];
    city = json['city'];
    country = json['country'];
    skill = json['skill'];
    salary = json['salary'];
    experience = json['experience'];
    user = json['user'];
    userId = json['userId'];
  }
}
