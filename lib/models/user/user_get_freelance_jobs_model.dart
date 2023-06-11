class UserGetFreelanceJobsModel {
  int? id;
  String? userId;
  String? projectDetails;
  String? title;
  String? budget;
  String? projectOwner;
  String? pictureUrl;

  UserGetFreelanceJobsModel(
      {this.id,
        this.projectDetails,
        this.userId,
        this.title,
        this.budget,
        this.projectOwner,
        this.pictureUrl});

  UserGetFreelanceJobsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    projectDetails = json['projectDetails'];
    title = json['title'];
    budget = json['budget'];
    projectOwner = json['projectOwner'];
    pictureUrl = json['pictureUrl'];
  }
}
