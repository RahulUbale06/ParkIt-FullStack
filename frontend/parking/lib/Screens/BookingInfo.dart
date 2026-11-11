
// class BookingInfo extends StatelessWidget {
//   final Map<String, String> booking;

//   const BookingInfo({
//     super.key,
//     required this.booking,
//   });

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingInfo extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingInfo({
    super.key,
    required this.booking,
  });

  static const Color primaryGreen = Color(0xFF176B43);
  static const Color lightGreen = Color(0xFFE5F1E8);

  String getValue(
    List<String> keys, {
    String fallback = 'Not available',
  }) {
    for (final key in keys) {
      final value = booking[key];

      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }

    return fallback;
  }

  String formatDate(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return 'Not available';
    }

    try {
      final date = DateTime.parse(value.toString()).toLocal();
      return DateFormat('dd MMMM yyyy').format(date);
    } catch (_) {
      return value.toString();
    }
  }

  String formatTime(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return 'Not available';
    }

    try {
      final date = DateTime.parse(value.toString()).toLocal();
      return DateFormat('hh:mm a').format(date);
    } catch (_) {
      return value.toString();
    }
  }

  Widget detailRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 21,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingId = getValue(['_id', 'id']);
    final status = getValue(['bookingStatus', 'status']);

    final bookingDate = booking['createdAt'] ??
        booking['bookingDate'];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      appBar: AppBar(
        title: const Text(
          'Booking Information',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryGreen,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking ID and status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking ID',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bookingId,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: primaryGreen,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        status,
                        style: const TextStyle(
                          color: primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 10),

            detailRow(
              'Username',
              getValue(['username']),
              Icons.person_outline,
            ),

            detailRow(
              'Email',
              getValue(['email']),
              Icons.email_outlined,
            ),

            detailRow(
              'Phone Number',
              getValue(['phone']),
              Icons.phone_outlined,
            ),

            const SizedBox(height: 18),

            const Text(
              'Vehicle Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 10),

            detailRow(
              'Car Number',
              getValue(['carNumber']),
              Icons.directions_car_outlined,
            ),

            detailRow(
              'Vehicle Type',
              getValue(['vehicleType']),
              Icons.commute_outlined,
            ),

            const SizedBox(height: 18),

            const Text(
              'Parking Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 10),

            detailRow(
              'Slot Number',
              getValue(['slotNumber']),
              Icons.local_parking,
            ),

            detailRow(
              'Location ID',
              getValue(['locationId']),
              Icons.tag,
            ),

            detailRow(
              'Parking Location',
              getValue(['location', 'parkingLocation']),
              Icons.location_on_outlined,
            ),

            const SizedBox(height: 18),

            const Text(
              'Booking Timing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 10),

            detailRow(
              'Booking Date',
              formatDate(bookingDate),
              Icons.calendar_today_outlined,
            ),

            detailRow(
              'Entry Time',
              formatTime(booking['entryTime']),
              Icons.login,
            ),

            detailRow(
              'Exit Time',
              formatTime(booking['exitTime']),
              Icons.logout,
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
