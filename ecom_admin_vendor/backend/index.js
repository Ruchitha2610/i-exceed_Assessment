require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const cron = require('node-cron');
const bcrypt = require('bcryptjs');
const bodyParser = require('body-parser');

const app = express();
app.use(cors());
app.use(bodyParser.json()); // for both admin and vendor

// Routes
const adminRoutes = require('./routes/adminRoutes');
const vendorRoutes = require('./routes/vendorRoute');
app.use('/admin', adminRoutes);
app.use('/vendor', vendorRoutes);

// MongoDB Models
const Admin = require('./models/Admin');
const AdminOtp = require('./models/AdminOtp');
const VendorOtp = require('./models/VendorOtp');

// MongoDB connection
mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log('✅ MongoDB connected');
    insertDefaultAdmin();
    startAdminOtpCleanup(); // ⏰ Admin OTP cleanup
  })
  .catch(err => console.error('❌ MongoDB connection failed', err));

// 🔐 Insert default admin if not present
async function insertDefaultAdmin() {
  const existingAdmin = await Admin.findOne({ email: 'nruchitha169@gmail.com' });
  if (!existingAdmin) {
    const hashedPassword = await bcrypt.hash('admin@123', 10);
    await Admin.create({
      email: 'nruchitha169@gmail.com',
      password: hashedPassword,
    });
    console.log('🛠️ Default admin created: nruchitha169@gmail.com / admin@123');
  } else {
    console.log('ℹ️ Default admin already exists');
  }
}

// ⏰ Scheduled job to clean expired OTPs (Admin only, Vendor uses TTL)
function startAdminOtpCleanup() {
  cron.schedule('*/10 * * * *', async () => {
    const now = new Date();
    await AdminOtp.deleteMany({ expiresAt: { $lt: now } });
    console.log('🧹 Expired Admin OTPs cleaned up');
  });
}

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
