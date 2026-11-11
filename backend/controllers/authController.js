const User = require("../models/User");
const bcrypt = require("bcryptjs");
const generateToken = require("../utils/generateToken");

// Format user response without exposing password
const formatUser = (user) => ({
  id: user._id.toString(),
  username: user.username,
  email: user.email,
});

// ==================== SIGNUP ====================
exports.signup = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    // Validate required fields
    if (
      typeof username !== "string" ||
      typeof email !== "string" ||
      typeof password !== "string" ||
      !username.trim() ||
      !email.trim() ||
      !password
    ) {
      return res.status(400).json({
        success: false,
        message: "Username, email and password are required",
      });
    }

    const cleanUsername = username.trim();
    const cleanEmail = email.trim().toLowerCase();

    // Validate username
    if (cleanUsername.length < 3 || cleanUsername.length > 30) {
      return res.status(400).json({
        success: false,
        message: "Username must contain 3 to 30 characters",
      });
    }

    // Validate email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(cleanEmail)) {
      return res.status(400).json({
        success: false,
        message: "Please enter a valid email address",
      });
    }

    // Validate password
    if (password.length < 8) {
      return res.status(400).json({
        success: false,
        message: "Password must contain at least 8 characters",
      });
    }

    // Check existing username or email
    const existingUser = await User.findOne({
      $or: [
        { username: cleanUsername },
        { email: cleanEmail },
      ],
    });

    if (existingUser) {
      return res.status(409).json({
        success: false,
        message: "Username or email already exists",
      });
    }

    // Hash password using bcrypt
    const hashedPassword = await bcrypt.hash(password, 12);

    // Create user
    const user = await User.create({
      username: cleanUsername,
      email: cleanEmail,
      password: hashedPassword,
    });

    // Generate JWT
    const token = generateToken(user._id);

    return res.status(201).json({
      success: true,
      message: "Signup successful",
      token,
      user: formatUser(user),
    });
  } catch (error) {
    if (error.code === 11000) {
      return res.status(409).json({
        success: false,
        message: "Username or email already exists",
      });
    }

    console.error("Signup error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Unable to create account",
    });
  }
};

// ==================== LOGIN ====================
exports.login = async (req, res) => {
  try {
      const { username, password } = req.body;
      console.log("Received username:", username);
console.log("Received password length:", password?.length);
    // Validate request
    if (
      typeof username !== "string" ||
      typeof password !== "string" ||
      !username.trim() ||
      !password
    ) {
      return res.status(400).json({
        success: false,
        message: "Username and password are required",
      });
    }

    const loginInput = username.trim();

    // Find user by username OR email
    const user = await User.findOne({
      $or: [
        { username: loginInput },
        { email: loginInput.toLowerCase() },
      ],
    }).select("+password");

    // DEBUG LOGS: user lookup
    console.log("Login input:", loginInput);
    console.log("User found:", !!user);
    console.log("Stored password exists:", !!user?.password);

    if (!user) {
      return res.status(401).json({
        success: false,
        message: "Invalid username or password",
      });
    }

    // Verify password
    if (!user.password) {
      console.error(
        "Password hash missing for user:",
        user.username
      );

      return res.status(500).json({
        success: false,
        message: "Unable to verify password",
      });
    }

    const isMatch = await bcrypt.compare(
      password,
      user.password
    );

    // DEBUG LOG: password comparison
    console.log("Password matches:", isMatch);

    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: "Invalid username or password",
      });
    }

    // Generate JWT
    const token = generateToken(user._id);

    return res.status(200).json({
      success: true,
      message: "Login successful",
      token,
      user: formatUser(user),
    });
  } catch (error) {
    console.error("Login error:", error);

    return res.status(500).json({
      success: false,
      message: "Unable to login",
    });
  }
};

// ==================== GET CURRENT USER ====================
exports.getMe = async (req, res) => {
  try {
    return res.status(200).json({
      success: true,
      user: formatUser(req.user),
    });
  } catch (error) {
    console.error("Get profile error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Unable to fetch profile",
    });
  }
};