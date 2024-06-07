// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: ClipPath(
            clipper: CustomAppBarClipper(),
            child: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 0, 50),
              toolbarHeight: 110,
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text('Create your account!!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                labelText: 'Enter Email',
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 55),
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Email',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 55),
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 55),
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 55),
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text('Sign Up'),
            ),
          ]
        ),
      )
    );
  }
}
