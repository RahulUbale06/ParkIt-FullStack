
import 'package:flutter/material.dart';

import 'package:parking/Screens/Splash.dart';
import 'package:parking/Screens/Home.dart';
import 'package:parking/Screens/Booking.dart';
import 'package:parking/Screens/MyBookings.dart';
import 'package:parking/Screens/Login.dart';
import 'package:parking/Screens/About.dart';
import 'package:parking/Screens/Profile.dart';
import 'package:parking/Screens/Signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Park It!',

      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 123, 250, 189),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      home: const Splash(),

      routes: {
        '/home': (context) => const Home(),
        '/booking': (context) => const Booking(),
        '/profile': (context) => const Profile(),
        '/about': (context) => const About(),
        '/my-bookings': (context) => const MyBookings(),
        '/login': (context) => const Login(),
        '/signup':(context) => const Signup(),
      },
    );
  }
}
