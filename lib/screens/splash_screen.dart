import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // wait then navigate
    Timer(Duration(seconds: 2), () {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      if (auth.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // light background
      body: Stack(
        children: [
          // center logo
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
          ),
          // bottom app name
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Text(
                'Smart E Shop',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
