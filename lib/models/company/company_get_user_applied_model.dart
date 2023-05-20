class CompanyGetAllUsersApplied {
  String? userId;
  String? titleOfJob;
  String? dateApplied;
  String? displayName;
  String? email;
  int? jobid;
  String? cvUrl;
  String? pictureUrl;

  CompanyGetAllUsersApplied(
      {this.userId,
        this.titleOfJob,
        this.dateApplied,
        this.displayName,
        this.email,
        this.jobid,
        this.cvUrl,
        this.pictureUrl});

  CompanyGetAllUsersApplied.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    titleOfJob = json['titleOfJob'];
    dateApplied = json['dateApplied'];
    displayName = json['displayName'];
    email = json['email'];
    jobid = json['jobid'];
    cvUrl = json['cvUrl'];
    pictureUrl = json['pictureUrl'];
  }
}
