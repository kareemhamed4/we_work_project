class CompanyProfileModel {
  String? displayName;
  String? email;
  String? profilePictureUrl;
  String? city;
  String? bio;
  String? country;
  String? experience;
  String? dateOfCreation;

  CompanyProfileModel(
      {this.displayName,
        this.email,
        this.profilePictureUrl,
        this.city,
        this.bio,
        this.experience,
        this.dateOfCreation,
        this.country});

  CompanyProfileModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    profilePictureUrl = json['profilePictureUrl'];
    city = json['city'];
    bio = json['bio'];
    experience = json['experince'];
    dateOfCreation = json['dateOfCreation'];
    country = json['country'];
  }
}
