import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi1_app/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxi1_app/home_screen.dart';
import 'package:taxi1_app/wallet.dart';
import 'package:taxi1_app/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocationProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Taxi App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const IntroScreen(),
          routes: {
            '/login': (context) => const Login(),
            '/home': (context) => const PageNav(),
          },
        )
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              FontAwesomeIcons.carAlt,
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
            const SizedBox(height: 50),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              icon: const Icon(Icons.login, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 0, 0, 50),
              label: const Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class PageNav extends StatefulWidget {
  const PageNav({super.key});

  @override
  State<PageNav> createState() => _PageNavState();
}

class _PageNavState extends State<PageNav> {
  int _currentIndex = 0;

  final List<Widget> _children = const [
    HomeScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

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
            backgroundColor: Color.fromARGB(255, 0, 0, 55)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
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

