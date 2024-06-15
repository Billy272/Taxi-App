import 'dart:io';

class UserProfile {
  final String name;
  final String email;
  final String password;
  final File? profileImage;

  const UserProfile({
    this.name = "",
    this.email = "",
    this.password = "",
    this.profileImage,
  });
}
