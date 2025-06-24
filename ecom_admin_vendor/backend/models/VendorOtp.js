// models/VendorOtp.js
const mongoose = require('mongoose');

const otpSchema = new mongoose.Schema({
  email: { type: String, required: true },
  code: { type: String, required: true },
  expiresAt: {
    type: Date,
    required: true,
    index: { expires: 0 } // TTL index: delete after expiresAt
  },
  attempts: { type: Number, default: 0 },
}, { timestamps: true });

module.exports = mongoose.model('VendorOtp', otpSchema);
