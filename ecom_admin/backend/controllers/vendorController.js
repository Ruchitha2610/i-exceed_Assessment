const Vendor = require('../models/vendor');
const Otp = require('../models/VendorOtp');
const { sendOtpEmail } = require('../utils/mailer');
const crypto = require('crypto');

// 📤 Send OTP for Registration
exports.sendOtp = async (req, res) => {
  try {
    const { email, password } = req.body;

    const existing = await Vendor.findOne({ email });
    if (existing) return res.status(400).json({ error: 'Email already in use' });

    const existingOtp = await Otp.findOne({ email });
    const now = new Date();

    if (existingOtp) {
      const timeLeft = (existingOtp.expiresAt - now) / 1000;
      if (timeLeft > 0 && existingOtp.attempts < 3) {
        return res.status(429).json({
          error: `OTP already sent. Try again after ${Math.ceil(timeLeft)} seconds.`,
        });
      }
    }

    const otpCode = crypto.randomInt(100000, 999999).toString();
    const expiresAt = new Date(Date.now() + 60000);

    await Otp.findOneAndUpdate(
      { email },
      { code: otpCode, expiresAt, attempts: 0 },
      { new: true, upsert: true }
    );

    await sendOtpEmail(email, otpCode, 'vendor', 'register');
    res.json({ success: true });

  } catch (err) {
    console.error('Send OTP Error:', err);
    res.status(500).json({ error: 'Server error while sending OTP' });
  }
};

// ✅ Verify OTP (Registration)
exports.verifyOtp = async (req, res) => {
  try {
    const { email, otp } = req.body;
    const rec = await Otp.findOne({ email });

    if (!rec) return res.status(400).json({ error: 'Please request an OTP first.' });

    const now = new Date();
    if (now > rec.expiresAt) {
      await rec.deleteOne();
      return res.status(400).json({ error: 'OTP has expired. Please request a new one.' });
    }

    if (rec.attempts >= 3) {
      return res.status(400).json({ error: 'Too many failed attempts. Please request a new OTP.' });
    }

    if (rec.code !== otp) {
      rec.attempts++;
      await rec.save();
      return res.status(400).json({ error: 'Invalid OTP. Please try again.' });
    }

    await rec.deleteOne(); // OTP verified
    res.json({ success: true });

  } catch (err) {
    console.error('Verify OTP Error:', err);
    res.status(500).json({ error: 'Server error while verifying OTP' });
  }
};

// ✅ Verify OTP (Login)
exports.verifyLoginOtp = async (req, res) => {
  try {
    const { email, otp } = req.body;
    const rec = await Otp.findOne({ email });

    if (!rec) return res.status(400).json({ error: 'Please request OTP for login first.' });

    const now = new Date();
    if (now > rec.expiresAt) {
      await rec.deleteOne();
      return res.status(400).json({ error: 'OTP expired. Request a new one.' });
    }

    if (rec.attempts >= 3) {
      return res.status(400).json({ error: 'Too many OTP attempts. Try again later.' });
    }

    if (rec.code !== otp) {
      rec.attempts++;
      await rec.save();
      return res.status(400).json({ error: 'Incorrect OTP' });
    }

    await rec.deleteOne();
    res.json({ success: true });
  } catch (err) {
    console.error('Verify Login OTP Error:', err);
    res.status(500).json({ error: 'Server error verifying login OTP' });
  }
};

// ✅ Verify OTP (Forgot Password)
exports.verifyForgotOtp = async (req, res) => {
  try {
    const { email, otp } = req.body;
    const rec = await Otp.findOne({ email });

    if (!rec) return res.status(400).json({ error: 'Please request OTP for password reset first.' });

    const now = new Date();
    if (now > rec.expiresAt) {
      await rec.deleteOne();
      return res.status(400).json({ error: 'OTP expired. Request a new one.' });
    }

    if (rec.attempts >= 3) {
      return res.status(400).json({ error: 'Too many OTP attempts. Try again later.' });
    }

    if (rec.code !== otp) {
      rec.attempts++;
      await rec.save();
      return res.status(400).json({ error: 'Incorrect OTP' });
    }

    await rec.deleteOne();
    res.json({ success: true });
  } catch (err) {
    console.error('Verify Forgot OTP Error:', err);
    res.status(500).json({ error: 'Server error verifying forgot password OTP' });
  }
};

// 🧾 Final Registration
exports.register = async (req, res) => {
  try {
    const {
      fullName,
      businessName,
      storeId,
      email,
      password,
    } = req.body;

    const vendor = new Vendor({ fullName, businessName, storeId, email });
    await vendor.setPassword(password); // assumes bcrypt setup
    await vendor.save();

    res.json({ success: true, vendorId: vendor._id });

  } catch (err) {
    console.error('Vendor Registration Error:', err);
    res.status(500).json({ error: 'Server error while registering vendor' });
  }
};

// 🆔 Check Store ID Availability
exports.checkStoreId = async (req, res) => {
  try {
    const { storeId } = req.body;

    if (!storeId) {
      return res.status(400).json({
        available: false,
        message: 'Store ID is required',
      });
    }

    const exists = await Vendor.findOne({ storeId });

    if (exists) {
      return res.status(200).json({
        available: false,
        message: 'Store ID already taken',
      });
    }

    return res.status(200).json({ available: true });

  } catch (err) {
    console.error('Store ID Check Error:', err);
    return res.status(500).json({
      available: false,
      message: 'Server error while checking store ID',
    });
  }
};

// 🟢 Vendor Login
exports.login = async (req, res) => {
  try {
    const { storeId, email, password, otp } = req.body;

    // 1. Validate Store ID
    const vendor = await Vendor.findOne({ storeId });
    if (!vendor) {
      return res.status(404).json({ error: 'Store ID not found' });
    }

    // 2. Match Email
    if (vendor.email !== email) {
      return res.status(400).json({ error: 'Email does not match the store ID' });
    }

    // 3. Match Password
    const isMatch = await vendor.comparePassword(password);
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid password' });
    }

    // 4. OTP Verification
    const rec = await Otp.findOne({ email });
    if (!rec) return res.status(400).json({ error: 'OTP not found. Please request OTP again.' });

    const now = new Date();
    if (now > rec.expiresAt) {
      await rec.deleteOne();
      return res.status(400).json({ error: 'OTP expired. Request a new one.' });
    }

    if (rec.attempts >= 3) {
      return res.status(400).json({ error: 'Too many OTP attempts. Try again later.' });
    }

    if (rec.code !== otp) {
      rec.attempts++;
      await rec.save();
      return res.status(400).json({ error: 'Incorrect OTP' });
    }

    await rec.deleteOne(); // OTP verified and removed
    res.json({ success: true, vendorId: vendor._id });

  } catch (err) {
    console.error('Vendor Login Error:', err);
    res.status(500).json({ error: 'Server error during login' });
  }
};

// 📤 Send Login OTP (only email required)
exports.sendLoginOtp = async (req, res) => {
  try {
    const { email, password, storeId } = req.body;

    const vendor = await Vendor.findOne({ email, storeId });
    if (!vendor) {
      return res.status(404).json({ error: 'Vendor with this email and store ID not found' });
    }

    const isMatch = await vendor.comparePassword(password);
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid password' });
    }

    const existingOtp = await Otp.findOne({ email });
    const now = new Date();

    if (existingOtp) {
      const timeLeft = (existingOtp.expiresAt - now) / 1000;
      if (timeLeft > 0 && existingOtp.attempts < 3) {
        return res.status(429).json({
          error: `OTP already sent. Try again after ${Math.ceil(timeLeft)} seconds.`,
        });
      }
    }

    const otpCode = crypto.randomInt(100000, 999999).toString();
    const expiresAt = new Date(Date.now() + 60000); // 60 sec

    await Otp.findOneAndUpdate(
      { email },
      { code: otpCode, expiresAt, attempts: 0 },
      { upsert: true, new: true }
    );

    await sendOtpEmail(email, otpCode, 'vendor', 'login');
    res.json({ success: true });
  } catch (err) {
    console.error('Send Login OTP Error:', err);
    res.status(500).json({ error: 'Server error sending login OTP' });
  }
};

// 📤 Send OTP for Forgot Password
exports.sendForgotOtp = async (req, res) => {
  try {
    const { email } = req.body;

    const vendor = await Vendor.findOne({ email });
    if (!vendor) return res.status(404).json({ error: 'Vendor not found' });

    const existingOtp = await Otp.findOne({ email });
    const now = new Date();

    if (existingOtp) {
      const timeLeft = (existingOtp.expiresAt - now) / 1000;
      if (timeLeft > 0 && existingOtp.attempts < 3) {
        return res.status(429).json({
          error: `OTP already sent. Try again after ${Math.ceil(timeLeft)} seconds.`,
        });
      }
    }

    const otpCode = crypto.randomInt(100000, 999999).toString();
    const expiresAt = new Date(Date.now() + 60000); // 60 sec

    await Otp.findOneAndUpdate(
      { email },
      {
        code: otpCode,
        expiresAt,
        $inc: { attempts: 1 }
      },
      { new: true, upsert: true }
    );

    await sendOtpEmail(email, otpCode, 'vendor', 'forgot');
    res.json({ success: true });

  } catch (err) {
    console.error('Send Forgot OTP Error:', err);
    res.status(500).json({ error: 'Server error sending OTP' });
  }
};

// 🔁 Reset Password After OTP Verification
exports.resetPassword = async (req, res) => {
  try {
    const { email, newPassword } = req.body;

    const vendor = await Vendor.findOne({ email });
    if (!vendor) return res.status(404).json({ error: 'Vendor not found' });

    await vendor.setPassword(newPassword);
    await vendor.save();

    res.json({ success: true });

  } catch (err) {
    console.error('Reset Password Error:', err);
    res.status(500).json({ error: 'Server error resetting password' });
  }
};
