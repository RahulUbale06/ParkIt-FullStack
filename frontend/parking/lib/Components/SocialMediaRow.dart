
import 'package:flutter/material.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.facebook,
      Icons.camera_alt_outlined,
      Icons.play_circle_fill,
      Icons.alternate_email,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons.map((icon) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(
            icon,
            size: 30,
            color:const Color.fromARGB(255, 45, 118, 47)
          ),
        );
      }).toList(),
    );
  }
}
