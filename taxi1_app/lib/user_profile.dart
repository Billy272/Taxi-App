import 'dart:io';

class UserProfile {
  final String name;
  final String email;
  final String password;
  final File? profileImage;

  UserProfile({
    required this.name,
    required this.email,
    required this.password,
    this.profileImage,
  });
}
