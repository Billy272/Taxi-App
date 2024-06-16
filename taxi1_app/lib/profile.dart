import 'package:flutter/material.dart';
// import 'dart:io';
import 'user_profile.dart';
import 'sign_up.dart';

class ProfilePage extends StatelessWidget {
  final UserProfile userProfile;

  const ProfilePage({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    print('UserProfile: ${userProfile.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 55),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: userProfile.profileImage != null
                          ? ClipOval(
                              child: Image.file(
                                userProfile.profileImage!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: 80,
                              color: Colors.grey[800],
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                userProfile.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('Email'),
              subtitle: Text('userProfile.email'),
            ),
            const ListTile(
              leading: Icon(Icons.lock_outlined),
              title: Text('Password'),
              subtitle: Text('userProfile.password'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Taxi App',
                  applicationVersion: '0.2.0',
                  applicationIcon: const Icon(Icons.account_circle_outlined),
                  children: <Widget>[
                    const Text(
                        'Leave alone a simple name like Taxi App, we\'re the best cab providers in town.'),
                  ],
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.security_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help & Support'),
              onTap: () {},
            ),
            ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                }),
          ],
        ),
      ),
    );
  }
}
