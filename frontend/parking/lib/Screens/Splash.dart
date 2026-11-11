import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking/Services/AuthService.dart';

import 'Home.dart';
import 'Login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static const Color primaryGreen = Color(0xFF176B43);
  static const Color backgroundGreen = Color(0xFFE5F1E8);

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Widget destination;

    try {
      final token = await AuthService.getToken();

      if (token == null || token.isEmpty) {
        destination = const Login();
      } else {
        // Verify that the saved token is still valid.
        await AuthService.getMe();
        destination = const Home();
      }
    } catch (_) {
      // Missing, expired, or invalid token.
      await AuthService.logout();
      destination = const Login();
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => destination,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.local_parking_rounded,
                color: Colors.white,
                size: 65,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Park It!',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your Parking, Made Easy.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF537462),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}