const Admin = require('../models/Admin');
const OTP = require('../models/AdminOtp');
const bcrypt = require('bcrypt');
const { sendOtpEmail } = require('../utils/mailer');

const MAX_ATTEMPTS = 3;
const LOCK_TIME = 15 * 60 * 1000; // 15 minutes

// 1️⃣ Initiate Login - check password and send OTP
exports.loginInitiate = async (req, res) => {
  const { email, password } = req.body;
  const admin = await Admin.findOne({ email });

  if (!admin) return res.status(401).json({ message: 'Email not found' });

  if (admin.lockUntil && admin.lockUntil > Date.now()) {
    return res.status(403).json({
      message: `Account locked. Try again after ${new Date(admin.lockUntil).toLocaleTimeString()}`,
    });
  }

  const isMatch = await bcrypt.compare(password, admin.password);
  if (!isMatch) {
    admin.loginAttempts += 1;
    if (admin.loginAttempts >= MAX_ATTEMPTS) {
      admin.lockUntil = new Date(Date.now() + LOCK_TIME);
      await admin.save();
      return res.status(403).json({ message: 'Account locked due to multiple failed attempts.' });
    }
    await admin.save();
    return res.status(401).json({
      message: `Invalid password. ${MAX_ATTEMPTS - admin.loginAttempts} attempts left.`,
    });
  }

  // Password correct, send OTP
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  const expiresAt = new Date(Date.now() + 5 * 60 * 1000);

  await OTP.deleteMany({ email }); // remove old OTPs
  await OTP.create({ email, code, expiresAt });

  try {
    await sendOtpEmail(email, code);
    res.status(200).json({ message: 'OTP sent to your email' });
  } catch (err) {
    res.status(500).json({ message: 'Failed to send OTP email' });
  }
};

// 2️⃣ Verify OTP after login password matched
exports.loginVerify = async (req, res) => {
  const { email, code } = req.body;
  const otpRecord = await OTP.findOne({ email, code });

  if (!otpRecord) return res.status(400).json({ message: 'Invalid OTP' });

  if (otpRecord.expiresAt < Date.now()) {
    await OTP.deleteMany({ email });
    return res.status(400).json({ message: 'OTP expired' });
  }

  const admin = await Admin.findOne({ email });
  if (!admin) return res.status(404).json({ message: 'Admin not found' });

  admin.loginAttempts = 0;
  admin.lockUntil = null;
  await admin.save();
  await OTP.deleteMany({ email });

  res.status(200).json({ message: 'Login successful', email });
};

// 3️⃣ Send OTP for Forgot Password
exports.sendOtp = async (req, res) => {
  const { email } = req.body;
  const admin = await Admin.findOne({ email });

  if (!admin) return res.status(404).json({ message: 'Email not found' });

  const code = Math.floor(100000 + Math.random() * 900000).toString();
  const expiresAt = new Date(Date.now() + 5 * 60 * 1000);

  await OTP.deleteMany({ email });
  await OTP.create({ email, code, expiresAt });

  try {
    await sendOtpEmail(email, code);
    res.status(200).json({ message: 'OTP sent to your email' });
  } catch (err) {
    res.status(500).json({ message: 'Failed to send OTP email' });
  }
};

// 4️⃣ Verify OTP (Forgot Password)
exports.verifyOTP = async (req, res) => {
  const { email, code } = req.body;
  const otpRecord = await OTP.findOne({ email, code });

  if (!otpRecord) return res.status(400).json({ message: 'Invalid OTP' });

  if (otpRecord.expiresAt < Date.now()) {
    await OTP.deleteMany({ email });
    return res.status(400).json({ message: 'OTP expired' });
  }

  res.status(200).json({ message: 'OTP verified' });
};

// 5️⃣ Reset Password (Forgot Password)
exports.resetPassword = async (req, res) => {
  const { email, newPassword, confirmPassword } = req.body;

  if (newPassword !== confirmPassword)
    return res.status(400).json({ message: 'Passwords do not match' });

  const admin = await Admin.findOne({ email });
  if (!admin) return res.status(400).json({ message: 'Email not found' });

  admin.password = await bcrypt.hash(newPassword, 10);
  await admin.save();
  await OTP.deleteMany({ email });

  res.status(200).json({ message: 'Password reset successfully' });
};
