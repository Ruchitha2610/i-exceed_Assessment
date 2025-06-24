const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  service: 'gmail', // or use 'host' & 'port' if using custom SMTP
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

/**
 * Sends an OTP email for login, registration, or password reset.
 * @param {string} to - Receiver's email
 * @param {string} otp - OTP code
 * @param {'admin'|'vendor'} role - Role of the receiver
 * @param {'login'|'register'|'forgot'} type - Purpose of OTP
 */
exports.sendOtpEmail = async (to, otp, role = 'vendor', type = 'login') => {
  const isAdmin = role === 'admin';

  const subjectMap = {
    login: isAdmin ? 'Admin Login Verification - OTP' : 'Vendor Login OTP',
    register: isAdmin ? 'Admin Registration - OTP' : 'Vendor Registration OTP',
    forgot: isAdmin ? 'Admin Password Reset - OTP' : 'Vendor Password Reset OTP',
  };

  const introMap = {
    login: `<p>Please use the following OTP to complete your login:</p>`,
    register: `<p>Use the OTP below to verify your email and complete registration:</p>`,
    forgot: `<p>You requested to reset your password. Use the OTP below:</p>`,
  };

  const mailOptions = {
    from: `${isAdmin ? 'EcomHub Admin' : 'EcomHub Vendor'} <${process.env.EMAIL_USER}>`,
    to,
    subject: subjectMap[type],
    html: `
      <h3>Hello ${isAdmin ? 'Admin' : 'Vendor'},</h3>
      ${introMap[type]}
      <h2>${otp}</h2>
      <p>This OTP is valid for ${isAdmin ? '5 minutes' : '60 seconds'}.</p>
      <p>If you did not initiate this request, please ignore this email.</p>
    `,
  };

  return transporter.sendMail(mailOptions);
};
