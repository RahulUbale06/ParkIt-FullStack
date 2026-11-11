
import 'package:flutter/material.dart';
import 'package:parking/Components/AppBottomNavigation.dart';

import '../Services/ApiService.dart';
import '../Services/AuthService.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  static const Color primaryGreen = Color(0xFF176B43);

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final carNumberController = TextEditingController();
  final slotNumberController = TextEditingController();
  final locationIdController = TextEditingController();

  String? selectedVehicle;
  TimeOfDay? entryTime;
  TimeOfDay? exitTime;

  bool isLoading = false;
  bool isLoadingProfile = true;

  final List<String> vehicleTypes = [
    'Two Wheeler',
    'Four Wheeler',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  // Load the logged-in user's profile into editable fields.
  Future<void> loadUserProfile() async {
    try {
      final response = await AuthService.getMe();
      final user = response['user'];

      if (user == null || user is! Map<String, dynamic>) {
        throw Exception('Unable to load user profile.');
      }

      if (!mounted) return;

      setState(() {
        final TextEditingController _usernameController = TextEditingController();
        final TextEditingController _emailController = TextEditingController(); 
        isLoadingProfile = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingProfile = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString().replaceFirst('Exception: ', ''),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> selectTime(bool isEntry) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: isEntry
          ? entryTime ?? TimeOfDay.now()
          : exitTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && mounted) {
      setState(() {
        if (isEntry) {
          entryTime = pickedTime;
        } else {
          exitTime = pickedTime;
        }
      });
    }
  }

  int convertTimeToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  DateTime timeToDateTime(TimeOfDay time) {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> submitBooking() async {
    if (isLoadingProfile) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait while your profile loads.'),
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedVehicle == null ||
        entryTime == null ||
        exitTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all booking details.'),
        ),
      );
      return;
    }

    if (convertTimeToMinutes(exitTime!) <=
        convertTimeToMinutes(entryTime!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Exit time must be later than entry time.',
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final token = await AuthService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Please login before booking.');
      }

      final startDateTime = timeToDateTime(entryTime!);
      final endDateTime = timeToDateTime(exitTime!);

      final response = await ApiService.post(
        '/bookings',
        {
          'username': usernameController.text.trim(),
          'email': emailController.text.trim().toLowerCase(),
          'phone': phoneController.text.trim(),
          'carNumber': carNumberController.text.trim().toUpperCase(),
          'vehicleType': selectedVehicle,
          'slotNumber': slotNumberController.text.trim(),
          'locationId': locationIdController.text.trim(),
          'entryTime': startDateTime.toIso8601String(),
          'exitTime': endDateTime.toIso8601String(),
        },
        token: token,
      );

      if (!mounted) return;

      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message']?.toString() ??
                  'Booking created successfully!',
            ),
            backgroundColor: primaryGreen,
          ),
        );

        // Clear only booking-specific fields.
        // Keep username and email for the next booking.
        phoneController.clear();
        carNumberController.clear();
        slotNumberController.clear();
        locationIdController.clear();

        setState(() {
          selectedVehicle = null;
          entryTime = null;
          exitTime = null;
        });
      } else {
        throw Exception(
          response['message']?.toString() ??
              'Booking could not be created.',
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString().replaceFirst('Exception: ', ''),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: isLoading,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: primaryGreen,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: primaryGreen,
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }

          if (label == 'Email' &&
              !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                  .hasMatch(value.trim())) {
            return 'Enter a valid email address';
          }

          if (label == 'Phone Number' &&
              !RegExp(r'^\d{10}$').hasMatch(value.trim())) {
            return 'Enter a valid 10-digit phone number';
          }

          return null;
        },
      ),
    );
  }

  Widget buildTimePicker({
    required String title,
    required TimeOfDay? selectedTime,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: primaryGreen,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      selectedTime == null
                          ? 'Select time'
                          : selectedTime.format(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    carNumberController.dispose();
    slotNumberController.dispose();
    locationIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                const Center(
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    'Fill in your details to reserve a parking slot',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Editable username.
                buildTextField(
                  label: 'Username',
                  icon: Icons.person_outline,
                  controller: usernameController,
                ),

                // Editable email.
                buildTextField(
                  label: 'Email',
                  icon: Icons.email_outlined,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                buildTextField(
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),

                buildTextField(
                  label: 'Car Number',
                  icon: Icons.directions_car_outlined,
                  controller: carNumberController,
                ),

                buildTextField(
                  label: 'Slot Number',
                  icon: Icons.local_parking,
                  controller: slotNumberController,
                  keyboardType: TextInputType.number,
                ),

                buildTextField(
                  label: 'Location ID',
                  icon: Icons.location_on_outlined,
                  controller: locationIdController,
                  keyboardType: TextInputType.number,
                ),

                const Text(
                  'Vehicle Type',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  value: selectedVehicle,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.directions_car,
                      color: primaryGreen,
                    ),
                    hintText: 'Select vehicle type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: vehicleTypes.map((vehicle) {
                    return DropdownMenuItem<String>(
                      value: vehicle,
                      child: Text(vehicle),
                    );
                  }).toList(),
                  onChanged: isLoading
                      ? null
                      : (value) {
                          setState(() {
                            selectedVehicle = value;
                          });
                        },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select vehicle type';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                const Text(
                  'Parking Duration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    buildTimePicker(
                      title: 'Entry Time',
                      selectedTime: entryTime,
                      onTap: isLoading
                          ? () {}
                          : () => selectTime(true),
                    ),
                    const SizedBox(width: 12),
                    buildTimePicker(
                      title: 'Exit Time',
                      selectedTime: exitTime,
                      onTap: isLoading
                          ? () {}
                          : () => selectTime(false),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isLoading || isLoadingProfile
                        ? null
                        : submitBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading || isLoadingProfile
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(
        selectedIndex: 1,
      ),
    );
  }
}
