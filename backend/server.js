
const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");

dotenv.config();

const connectDB = require("./config/db");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Database connection
connectDB();

// Health check
app.get("/", (req, res) => {
  res.status(200).json({
    success: true,
    message: "Park It! Backend is running",
  });
});

// Authentication routes
app.use("/api/auth", require("./routes/authRoutes"));

// Booking routes
app.use("/api/bookings", require("./routes/bookingRoutes"));
// Handle unknown routes
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: "API endpoint not found",
  });
});

// Start server
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
