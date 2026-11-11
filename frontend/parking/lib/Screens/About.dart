
import 'package:flutter/material.dart';
import 'package:parking/Components/AppBottomNavigation.dart';
import 'package:parking/Components/SocialMediaRow.dart';

class About extends StatelessWidget {
  const About({super.key});

  static const Color primaryGreen = Color(0xFF176B43);
  static const Color lightGreen = Color(0xFFE5F1E8);

  final List<Map<String, String>> parkingFeatures = const [
    {
      'title': 'Easy Parking',
      'info': 'Find convenient parking spaces with ease.',
      'image':
          'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=600',
    },
    {
      'title': 'Safe Parking',
      'info': 'Park your vehicle with greater peace of mind.',
      'image':
          'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=600',
    },
    {
      'title': 'Save Time',
      'info': 'Reduce the time spent searching for parking.',
      'image':
          'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=600',
    },
    {
      'title': 'Organised Spaces',
      'info': 'Enjoy a simple and organised parking experience.',
      'image':
          'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=600',
    },
  ];

  final List<String> terms = const [
    'Users must provide correct personal and vehicle details.',
    'Users must select the correct vehicle type.',
    'Users must enter a valid parking slot number.',
    'Vehicles must be parked only in the assigned parking slot.',
    'Users must follow the parking location rules and instructions.',
    'Users are responsible for their personal belongings.',
    'Any damage caused to the parking property is the user’s responsibility.',
    'Users must follow the selected entry and exit timings.',
    'Parking availability is subject to the spaces available.',
    'Park It! reserves the right to update these terms when required.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Page heading
              const Center(
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // About app information card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Park It!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Park It! is a simple parking management application '
                      'designed to make finding and booking parking spaces '
                      'easier. Our goal is to provide users with a convenient, '
                      'organised and user-friendly parking experience.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Parking features heading
              const Text(
                'Why Choose Park It?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),

              const SizedBox(height: 14),

              // 2 x 2 parking image grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: parkingFeatures.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) {
                  final feature = parkingFeatures[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            child: Image.network(
                              feature['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  color: lightGreen,
                                  width: double.infinity,
                                  child: const Icon(
                                    Icons.local_parking,
                                    size: 45,
                                    color: primaryGreen,
                                  ),
                                );
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  feature['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: primaryGreen,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  feature['info']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // Terms and conditions heading
              const Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),

              const SizedBox(height: 12),

              // Terms card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(
                    terms.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: lightGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                terms[index],
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Social media section
              const Center(
                child: Text(
                  'Connect With Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: SocialMediaRow(),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  '© 2026 Park It! All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const AppBottomNavigation(
        selectedIndex: 0,
      ),
    );
  }
}
