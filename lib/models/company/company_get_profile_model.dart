class CompanyProfileModel {
  String? displayName;
  String? email;
  String? profilePictureUrl;
  String? city;
  String? bio;
  String? country;

  CompanyProfileModel(
      {this.displayName,
        this.email,
        this.profilePictureUrl,
        this.city,
        this.bio,
        this.country});

  CompanyProfileModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    profilePictureUrl = json['profilePictureUrl'];
    city = json['city'];
    bio = json['bio'];
    country = json['country'];
  }
}
