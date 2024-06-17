import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:taxi1_app/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxi1_app/home_screen.dart';
import 'package:taxi1_app/wallet.dart';
import 'package:taxi1_app/profile.dart';
import 'package:taxi1_app/user_profile.dart';
// import 'package:taxi1_app/sign_up.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.blueGrey,
        child: const Text(
          'An error occurred. Please restart the app.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontStyle: FontStyle.italic,
          ),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const IntroScreen(),
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => PageNav(
              userProfile: UserProfile(email: '', name: '', password: ''),
            ),
      },
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Background image
        Positioned.fill(
          child: Image.network(
            'https://img.freepik.com/free-vector/order-taxi-isometric-illustration-with-yellow-taxi-car-big-image-modern-smartphone-with-mobile-app-taxi-service_1284-33017.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // Faded color overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 87, 117, 186).withOpacity(0.9),
                  const Color.fromARGB(255, 87, 117, 186).withOpacity(0.4),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),
        // Main content
        Scaffold(
          backgroundColor: Colors.transparent, // Set scaffold background to transparent
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.carRear,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Taxi App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned login button at the bottom
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Center(
            child:SizedBox(
              width: 200,
              height: 60,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              icon: const Icon(Icons.login, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 0, 0, 50),
              label: const Text('Log In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
              fontSize: 20),
              ),
            ),
          ),
        ),
        ),
      ],
    );
  }
}


class PageNav extends StatefulWidget {
  final UserProfile userProfile;

  const PageNav({super.key, required this.userProfile});

  @override
  State<PageNav> createState() => _PageNavState();
}

class _PageNavState extends State<PageNav> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _children = <Widget>[
      const HomeScreen(),
      const WalletScreen(),
      ProfilePage(userProfile: widget.userProfile),
    ];
  }

  late List<Widget> _children;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 0, 0, 55)),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Payment',
            backgroundColor: Color.fromARGB(255, 0, 0, 55),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 0, 0, 55),
          ),
        ],
      ),
    );
  }
}
