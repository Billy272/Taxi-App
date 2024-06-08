// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/home_screen.dart';
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
            const Text("Welcome to Taxi App",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 50),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 55),
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'First Name',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 55),
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 55),
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'Last Name',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 55),
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
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
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 55),
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: '+254.....',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 55),
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
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
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 55),
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Confirm Password",
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 55),
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/home'
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 50),
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              child: const Text('Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}
