
const express = require("express");

const {
  createBooking,
  getMyBookings,
  getBookingById,
} = require("../controllers/bookingController");

const protect = require("../middleware/authMiddleware");

const router = express.Router();

// All booking routes require authentication
router.use(protect);

router.post("/", createBooking);
router.get("/my", getMyBookings);
router.get("/:id", getBookingById);

module.exports = router;
