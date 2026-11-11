
import 'package:flutter/material.dart';

import 'package:parking/Components/HomeSlider.dart';
import 'package:parking/Components/SectionHeading.dart';
import 'package:parking/Screens/MyBookings.dart';
import 'package:parking/Components/ParkingInfoCard.dart';
import 'package:parking/Components/SocialMediaRow.dart';
import 'package:parking/Components/AppBottomNavigation.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final List<Map<String, String>> slides = const [
    {
      'title': 'Park Your Car Safely',
      'image':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70',
    },
    {
      'title': 'Easy and Convenient Parking',
      'image':
          'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7',
    },
    {
      'title': 'Find Your Perfect Parking Spot',
      'image':
          'https://images.unsplash.com/photo-1507136566006-cfc505b114fc',
    },
  ];

  final List<Map<String, String>> parkingCards = const [
    {
      'title': 'Safe and Secure Parking',
      'image':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70',
    },
    {
      'title': 'Easy Parking Experience',
      'image':
          'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7',
    },
    {
      'title': 'Convenient Parking Facilities',
      'image':
          'https://images.unsplash.com/photo-1507136566006-cfc505b114fc',
    },
  ];

  void handleMenu(BuildContext context, String value) {
    if (value == 'My Booking') {
  Navigator.pushNamed(context, '/my-bookings');
} if (value == 'About Us') {
  Navigator.pushNamed(context, '/about');
}
if (value == 'Login') {
  Navigator.pushNamed(context, '/login');
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF176B43),
        foregroundColor: Colors.white,

        title: const Text(
          'Park It!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            icon: const Icon(Icons.more_vert),

            onSelected: (value) {
              handleMenu(context, value);
              
            },

            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'About Us',
                child: Text('About Us'),
              ),
              PopupMenuItem(
                value: 'Login',
                child: Text('Login'),
              ),
              PopupMenuItem(
                value: 'My Booking',
                child: Text('My Booking'),
              ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            // Image Slider
            HomeSlider(slides: slides),

            const SizedBox(height: 20),

            // About Section
            const SectionHeading(
              title: 'About Park It!',
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Park It! is a simple and convenient parking solution '
                'designed to make your parking experience easier. '
                'Finding a parking space can sometimes be difficult '
                'and time-consuming. Our application helps users '
                'find and book available parking slots conveniently. '
                'You can explore parking options and choose a suitable '
                'slot according to your needs.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Parking Cards
            const SectionHeading(
              title: 'Our Parking Facilities',
            ),

            ListView.builder(
              itemCount: parkingCards.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemBuilder: (context, index) {
                return ParkingInfoCard(
                  title: parkingCards[index]['title']!,
                  image: parkingCards[index]['image']!,
                );
              },
            ),

            const SizedBox(height: 15),

            // Terms and Conditions
            const SectionHeading(
              title: 'Terms and Conditions',
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Users must provide accurate information while using '
                'the application. Parking slots are subject to '
                'availability. A booking should be made only for the '
                'selected vehicle and parking slot. Users are expected '
                'to follow the parking facility rules. Any damage '
                'caused to the parking property is the responsibility '
                'of the concerned user.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Social Media
            const SectionHeading(
              title: 'Explore Us On',
            ),

            const SocialMediaRow(),

            const SizedBox(height: 25),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: const AppBottomNavigation(
        selectedIndex: 0,
      ),
    );
  }
}
