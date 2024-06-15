import 'package:flutter/material.dart';
// import 'dart:io';
import 'user_profile.dart'; // Import the user profile model

class ProfilePage extends StatelessWidget {
  final UserProfile userProfile;

  ProfilePage({required this.userProfile});

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
                      color: Colors.blue,
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
                'Name: ${userProfile.name}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text('${userProfile.email}'),
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Password'),
              subtitle: Text('${userProfile.password}'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Profile App',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.account_circle),
                  children: <Widget>[
                    const Text('This is a sample profile app.'),
                  ],
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Privacy Policy'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {

              }
            ),
          ],
        ),
      ),
    );
  }
}
