const mongoose = require('mongoose');

const adminSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },

  loginAttempts: {
    type: Number,
    default: 0,
  },

  lockUntil: {
    type: Date,
    default: null,
  },

  otp: {
    code: { type: String },
    expiresAt: { type: Date },
  },
});

module.exports = mongoose.model('Admin', adminSchema);
