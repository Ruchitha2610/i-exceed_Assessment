const express = require('express');
const router = express.Router();
const vc = require('../controllers/vendorController');

router.post('/send-otp', vc.sendOtp);                       // Registration OTP
router.post('/verify-otp', vc.verifyOtp);                   // Registration OTP verification
router.post('/register', vc.register);                      // Registration final step
router.post('/check-store-id', vc.checkStoreId);            // Check store ID availability

router.post('/send-login-otp', vc.sendLoginOtp);            // Login - send OTP
router.post('/verify-login-otp', vc.verifyLoginOtp);        // ✅ Login - verify OTP
router.post('/login', vc.login);                            // Login with password + OTP

router.post('/send-forgot-otp', vc.sendForgotOtp);          // Forgot Password - send OTP
router.post('/verify-forgot-otp', vc.verifyForgotOtp);      // ✅ Forgot Password - verify OTP
router.post('/reset-password', vc.resetPassword);           // Reset password

module.exports = router;
