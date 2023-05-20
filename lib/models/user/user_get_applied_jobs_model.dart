class UserGetAppliedJobsModel {
  String? userId;
  String? name;
  String? piCtrueUrl;
  String? title;
  String? dateApplied;
  String? message;
  int? jobid;

  UserGetAppliedJobsModel(
      {this.userId,
        this.name,
        this.piCtrueUrl,
        this.title,
        this.dateApplied,
        this.message,
        this.jobid});

  UserGetAppliedJobsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    piCtrueUrl = json['piCtrueUrl'];
    title = json['title'];
    dateApplied = json['dateApplied'];
    message = json['message'];
    jobid = json['jobid'];
  }
}
