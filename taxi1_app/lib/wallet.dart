import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final controller = PageController(viewportFraction: 0.8);

  Future<void> safeLaunch(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
            const Center(
              child: Text(
                'Select a payment method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            width: 500,
            child: PageView(
              controller: controller,
              children: <Widget>[
                WalletCard(
                  title: 'M-Pesa',
                  trailing: const Icon(Icons.phone_android_outlined, color: Colors.white70),
                  description: 'Pay via M-Pesa',
                  buttonText: 'Pay Now',
                  buttonAction: () {
                    safeLaunch('tel:*334#');
                  },
                  buttonColor: Colors.green,
                ),
                WalletCard(
                  title: 'Airtel Money',
                  trailing: const Icon(Icons.phone_android_outlined, color: Colors.white70),
                  description: 'Pay via Airtel Money',
                  buttonText: 'Pay Now',
                  buttonAction: () {
                    safeLaunch('tel:*334#');
                  },
                  buttonColor: Colors.red.shade800,
                ),
                WalletCard(
                  title: 'Google Pay',
                  description: 'Pay via Google Pay',
                  trailing: const Icon(Icons.g_mobiledata, color: Colors.white70),
                  buttonAction: () {
                    return safeLaunch('https://pay.google.com/');
                  },
                  buttonColor: Colors.blue,
                  buttonText: 'Pay Now',
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Color.fromARGB(255, 0, 0, 55),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Amount to Pay: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text('Ksh. 500',
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget trailing;
  final String buttonText;
  final Function buttonAction;
  final Color buttonColor;

  const WalletCard({
    super.key,
    required this.title,
    required this.description,
    required this.trailing,
    required this.buttonText,
    required this.buttonAction,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 300,
        height: 150,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => buttonAction(),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailing,
                  const SizedBox(width: 5),
                  Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
