class UserProfileModel {
  String? displayName;
  String? cv;
  String? email;
  String? profilePictureUrl;
  String? city;
  String? bio;
  String? country;
  String? education;

  UserProfileModel(
      {this.displayName,
        this.cv,
        this.email,
        this.profilePictureUrl,
        this.city,
        this.bio,
        this.country,
        this.education});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    cv = json['cv'];
    email = json['email'];
    profilePictureUrl = json['profilePictureUrl'];
    city = json['city'];
    bio = json['bio'];
    country = json['country'];
    education = json['education'];
  }
}
