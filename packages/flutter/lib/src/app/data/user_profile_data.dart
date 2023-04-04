abstract class UserProfileData {
  UserProfileData({
    this.name,
    this.email,
    this.phone,
    this.language,
    this.verified = false,
  });

  // personal details\
  String? name;
  String? email;
  String? phone;
  String? language;

  // verification
  bool verified;
}
