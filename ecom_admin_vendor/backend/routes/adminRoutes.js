const express = require('express');
const router = express.Router();
const {
  loginInitiate,
  loginVerify,
  sendOtp,
  verifyOTP,
  resetPassword
} = require('../controllers/adminController');

// 🔐 Login flow
router.post('/login-initiate', loginInitiate); // password check + send OTP
router.post('/login-verify', loginVerify);     // OTP verification after password check

// 🔑 Forgot password flow
router.post('/send-otp', sendOtp);             // send OTP for password reset
router.post('/verify-otp', verifyOTP);         // verify OTP for password reset
router.post('/reset-password', resetPassword); // reset password after OTP verification

module.exports = router;
