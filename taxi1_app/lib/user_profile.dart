import 'dart:io' show File;

class UserProfile {
  String name;
  String email;
  String password;
  File? profileImage;

  UserProfile({
    required this.name,
    required this.email,
    required this.password,
    this.profileImage,
  });
}
