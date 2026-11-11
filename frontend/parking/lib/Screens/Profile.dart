
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:parking/Components/AppBottomNavigation.dart';

class Profile extends StatelessWidget {
  final String? username;
  final String? email;

  const Profile({
    super.key,
    this.username,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn =
        username != null &&
        username!.trim().isNotEmpty &&
        email != null &&
        email!.trim().isNotEmpty;

    final String firstLetter = isLoggedIn
        ? username!.trim()[0].toUpperCase()
        : '?';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: const Color(0xFF176B43),

                  child: Text(
                    firstLetter,
                    style: const TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                if (isLoggedIn) ...[
                  Text(
                    username!,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF176B43),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    email!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ] else ...[
                  const Text(
                    'Login / Signup Required',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF176B43),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Please login or create an account '
                    'to view your profile information.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176B43),
                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        'Login / Signup',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: const AppBottomNavigation(
        selectedIndex: 2,
      ),
    );
  }
}
