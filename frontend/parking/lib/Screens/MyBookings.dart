// import 'package:flutter/material.dart';
// import 'package:parking/Components/AppBottomNavigation.dart';
// import 'BookingInfo.dart';

// class MyBookings extends StatelessWidget {
//   const MyBookings({super.key});

//   static const Color primaryGreen = Color(0xFF176B43);
//   static const Color lightGreen = Color(0xFFE5F1E8);

//   // Temporary booking data.
//   final List<Map<String, String>> bookings = const [
//     {
//       'id': 'BK001',
//       'username': 'Rahul Sharma',
//       'email': 'rahul@gmail.com',
//       'phone': '9876543210',
//       'carNumber': 'MH12AB1234',
//       'vehicleType': 'Four Wheeler',
//       'slotNumber': 'A-12',
//       'locationId': 'LOC101',
//       'location': 'Pune Central Parking',
//       'entryTime': '10:00 AM',
//       'exitTime': '02:00 PM',
//       'bookingDate': '25 October 2026',
//       'status': 'Confirmed',
//     },
//     {
//       'id': 'BK002',
//       'username': 'Amit Patil',
//       'email': 'amit@gmail.com',
//       'phone': '9876501234',
//       'carNumber': 'MH14CD5678',
//       'vehicleType': 'Two Wheeler',
//       'slotNumber': 'B-05',
//       'locationId': 'LOC102',
//       'location': 'City Mall Parking',
//       'entryTime': '11:00 AM',
//       'exitTime': '01:00 PM',
//       'bookingDate': '26 October 2026',
//       'status': 'Confirmed',
//     },
//     {
//       'id': 'BK003',
//       'username': 'Priya Deshmukh',
//       'email': 'priya@gmail.com',
//       'phone': '9876512345',
//       'carNumber': 'MH15EF9012',
//       'vehicleType': 'Four Wheeler',
//       'slotNumber': 'C-08',
//       'locationId': 'LOC103',
//       'location': 'Station Road Parking',
//       'entryTime': '09:00 AM',
//       'exitTime': '12:00 PM',
//       'bookingDate': '27 October 2026',
//       'status': 'Confirmed',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9F7),

//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // Heading
//             const Padding(
//               padding: EdgeInsets.fromLTRB(18, 20, 18, 5),
//               child: Text(
//                 'My Bookings',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: primaryGreen,
//                 ),
//               ),
//             ),

//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 18),
//               child: Text(
//                 'View and manage your parking bookings',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Booking cards or empty state
//             Expanded(
//               child: bookings.isEmpty
//                   ? const Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.local_parking_outlined,
//                             size: 75,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(height: 15),
//                           Text(
//                             'No bookings done yet',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(height: 7),
//                           Text(
//                             'Your parking bookings will appear here.',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       itemCount: bookings.length,
//                       itemBuilder: (context, index) {
//                         final booking = bookings[index];

//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => BookingInfo(
//                                   booking: booking,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 14),
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(
//                                 color: Colors.grey.shade200,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.04),
//                                   blurRadius: 6,
//                                   offset: const Offset(0, 3),
//                                 ),
//                               ],
//                             ),

//                             child: Row(
//                               children: [

//                                 // Parking icon
//                                 Container(
//                                   height: 55,
//                                   width: 55,
//                                   decoration: BoxDecoration(
//                                     color: lightGreen,
//                                     borderRadius:
//                                         BorderRadius.circular(12),
//                                   ),
//                                   child: const Icon(
//                                     Icons.local_parking,
//                                     color: primaryGreen,
//                                     size: 30,
//                                   ),
//                                 ),

//                                 const SizedBox(width: 14),

//                                 // Booking summary
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         booking['username']!,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),

//                                       const SizedBox(height: 7),

//                                       Text(
//                                         'Car No: ${booking['carNumber']}',
//                                         style: const TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.black54,
//                                         ),
//                                       ),

//                                       const SizedBox(height: 4),

//                                       Text(
//                                         'Slot No: ${booking['slotNumber']}',
//                                         style: const TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 const Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 17,
//                                   color: primaryGreen,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: const AppBottomNavigation(
//         selectedIndex: 1,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:parking/Components/AppBottomNavigation.dart';
import 'package:parking/Services/ApiService.dart';
import 'package:parking/Services/AuthService.dart';

import 'BookingInfo.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  static const Color primaryGreen = Color(0xFF176B43);
  static const Color lightGreen = Color(0xFFE5F1E8);

  List<Map<String, dynamic>> bookings = [];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final token = await AuthService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Please log in again to view your bookings.');
      }

      final response = await ApiService.get(
  '/bookings/my',
  token: token,
);

      // Backend may return:
      // { "bookings": [...] }
      // or { "data": [...] }
      final dynamic bookingList =
          response['bookings'] ?? response['data'];

      if (bookingList is! List) {
        throw Exception('Invalid bookings response from server.');
      }

      final fetchedBookings = bookingList
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();

      if (!mounted) return;

      setState(() {
        bookings = fetchedBookings;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  String displayValue(
    dynamic value, {
    String fallback = 'N/A',
  }) {
    if (value == null || value.toString().trim().isEmpty) {
      return fallback;
    }

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 20, 18, 5),
              child: Text(
                'My Bookings',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'View and manage your parking bookings',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Booking list
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryGreen,
                      ),
                    )
                  : errorMessage != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 55,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  errorMessage!,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: fetchBookings,
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : bookings.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_parking_outlined,
                                    size: 75,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'No bookings done yet',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    'Your parking bookings will appear here.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: fetchBookings,
                              color: primaryGreen,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: bookings.length,
                                itemBuilder: (context, index) {
                                  final booking = bookings[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookingInfo(
                                            booking: booking,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 14,
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.04),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          // Parking icon
                                          Container(
                                            height: 55,
                                            width: 55,
                                            decoration: BoxDecoration(
                                              color: lightGreen,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.local_parking,
                                              color: primaryGreen,
                                              size: 30,
                                            ),
                                          ),

                                          const SizedBox(width: 14),

                                          // Booking summary
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  displayValue(
                                                    booking['username'],
                                                    fallback:
                                                        'Unnamed User',
                                                  ),
                                                  style:
                                                      const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 7,
                                                ),

                                                Text(
                                                  'Car No: ${displayValue(booking['carNumber'])}',
                                                  style:
                                                      const TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        Colors.black54,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 4,
                                                ),

                                                Text(
                                                  'Slot No: ${displayValue(booking['slotNumber'])}',
                                                  style:
                                                      const TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                            color: primaryGreen,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavigation(
        selectedIndex: 1,
      ),
    );
  }
}