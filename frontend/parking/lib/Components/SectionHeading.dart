
import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String title;

  const SectionHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Color(0xFF176B43),
        ),
      ),
    );
  }
}
