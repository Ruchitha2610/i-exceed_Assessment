const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const vendorSchema = new mongoose.Schema({
  fullName: { type: String, required: true },
  businessName: { type: String, required: true },
  storeId: { type: String, unique: true, required: true },
  email: { type: String, unique: true, required: true },
  passwordHash: { type: String, required: true },
}, { timestamps: true });

// 🔐 Hash password and store
vendorSchema.methods.setPassword = async function(pass) {
  const salt = await bcrypt.genSalt(10);
  this.passwordHash = await bcrypt.hash(pass, salt);
};

// ✅ Match password during login
vendorSchema.methods.comparePassword = function(pass) {
  return bcrypt.compare(pass, this.passwordHash);
};

module.exports = mongoose.model('Vendor', vendorSchema);
