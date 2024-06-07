import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                Text('Welcome Back!!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),),
                Text(
                  'Sign In',
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
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 55),
                ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 55),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );

  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.60, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height * 0.05);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}