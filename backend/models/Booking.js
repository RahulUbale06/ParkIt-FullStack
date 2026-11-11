
const mongoose = require("mongoose");

const bookingSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      index: true,
    },

    username: {
      type: String,
      required: true,
      trim: true,
    },

    email: {
      type: String,
      required: true,
      trim: true,
      lowercase: true,
    },

    phone: {
      type: String,
      required: true,
      trim: true,
    },

    carNumber: {
      type: String,
      required: true,
      trim: true,
      uppercase: true,
    },

    vehicleType: {
      type: String,
      required: true,
      enum: ["Two Wheeler", "Four Wheeler", "Other"],
    },

    slotNumber: {
      type: String,
      required: true,
      trim: true,
    },

    locationId: {
      type: String,
      required: true,
      trim: true,
    },

    entryTime: {
      type: Date,
      required: true,
    },

    exitTime: {
      type: Date,
      required: true,
    },

    bookingStatus: {
      type: String,
      enum: ["Confirmed", "Cancelled", "Completed"],
      default: "Confirmed",
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Booking", bookingSchema);
