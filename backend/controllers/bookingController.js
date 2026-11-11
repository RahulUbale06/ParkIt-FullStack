const Booking = require("../models/Booking");

// ==================== CREATE BOOKING ====================
exports.createBooking = async (req, res) => {
  try {
    const {
      username,
      email,
      phone,
      carNumber,
      vehicleType,
      slotNumber,
      locationId,
      entryTime,
      exitTime,
    } = req.body;

    // Validate required fields
    if (
      !username ||
      !email ||
      !phone ||
      !carNumber ||
      !vehicleType ||
      !slotNumber ||
      !locationId ||
      !entryTime ||
      !exitTime
    ) {
      return res.status(400).json({
        success: false,
        message: "All booking fields are required",
      });
    }

    // Validate username
    if (typeof username !== "string" || !username.trim()) {
      return res.status(400).json({
        success: false,
        message: "Enter a valid username",
      });
    }

    // Validate email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (
      typeof email !== "string" ||
      !emailRegex.test(email.trim())
    ) {
      return res.status(400).json({
        success: false,
        message: "Enter a valid email address",
      });
    }

    // Validate phone number
    if (
      typeof phone !== "string" ||
      !/^\+?[0-9]{10,15}$/.test(phone.trim())
    ) {
      return res.status(400).json({
        success: false,
        message: "Enter a valid phone number",
      });
    }

    // Validate vehicle type
    const allowedTypes = [
      "Two Wheeler",
      "Four Wheeler",
      "Other",
    ];

    if (!allowedTypes.includes(vehicleType)) {
      return res.status(400).json({
        success: false,
        message: "Invalid vehicle type",
      });
    }

    // Validate dates
    const start = new Date(entryTime);
    const end = new Date(exitTime);

    if (
      Number.isNaN(start.getTime()) ||
      Number.isNaN(end.getTime())
    ) {
      return res.status(400).json({
        success: false,
        message: "Invalid entry or exit time",
      });
    }

    if (end <= start) {
      return res.status(400).json({
        success: false,
        message: "Exit time must be after entry time",
      });
    }

    // Create booking using the form's username and email.
    // userId still comes from the authenticated JWT.
    const booking = await Booking.create({
      userId: req.user._id,

      username: username.trim(),
      email: email.trim().toLowerCase(),

      phone: phone.trim(),
      carNumber: carNumber.trim().toUpperCase(),
      vehicleType,
      slotNumber: slotNumber.trim(),
      locationId: locationId.trim(),

      entryTime: start,
      exitTime: end,
    });

    return res.status(201).json({
      success: true,
      message: "Booking created successfully",
      booking: {
        id: booking._id.toString(),
        username: booking.username,
        email: booking.email,
        carNumber: booking.carNumber,
        slotNumber: booking.slotNumber,
      },
    });
  } catch (error) {
    console.error("Create booking error:", error);

    return res.status(500).json({
      success: false,
      message: "Unable to create booking",
    });
  }
};

// ==================== GET MY BOOKINGS ====================
exports.getMyBookings = async (req, res) => {
  try {
    const bookings = await Booking.find({
      userId: req.user._id,
    })
      .sort({ createdAt: -1 })
      .select("username email carNumber slotNumber");

    return res.status(200).json({
      success: true,
      bookings: bookings.map((booking) => ({
        id: booking._id.toString(),
        username: booking.username,
        email: booking.email,
        carNumber: booking.carNumber,
        slotNumber: booking.slotNumber,
      })),
    });
  } catch (error) {
    console.error("Get bookings error:", error);

    return res.status(500).json({
      success: false,
      message: "Unable to fetch bookings",
    });
  }
};
// ==================== GET BOOKING DETAILS ====================
exports.getBookingById = async (req, res) => {
  try {
    const { id } = req.params;

    if (!/^[0-9a-fA-F]{24}$/.test(id)) {
      return res.status(404).json({
        success: false,
        message: "Booking not found",
      });
    }

    const booking = await Booking.findOne({
      _id: id,
      userId: req.user._id,
    });

    if (!booking) {
      return res.status(404).json({
        success: false,
        message: "Booking not found",
      });
    }

    return res.status(200).json({
      success: true,
      booking: {
        id: booking._id.toString(),
        username: booking.username,
        email: booking.email,
        phone: booking.phone,
        carNumber: booking.carNumber,
        vehicleType: booking.vehicleType,
        slotNumber: booking.slotNumber,
        locationId: booking.locationId,

        // Use locationId as fallback if location name is not stored.
        location: booking.location || booking.locationId || "Not available",

        entryTime: booking.entryTime,
        exitTime: booking.exitTime,

        // Use createdAt as booking date.
        bookingDate: booking.createdAt,

        bookingStatus: booking.bookingStatus,
      },
    });
  } catch (error) {
    console.error("Get booking details error:", error);

    return res.status(500).json({
      success: false,
      message: "Unable to fetch booking details",
    });
  }
};