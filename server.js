const mongoose = require('mongoose');
const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Initialize Express app
const app = express();

// Middleware
app.use(bodyParser.json());

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/hotelApp', {
  // Removed useNewUrlParser and useUnifiedTopology options
});

// Define MongoDB Schema and Models
const User = mongoose.model('User', {
  loginId: String,
  password: String,
});

// Express routes and server setup
app.listen(3000, () => {
  console.log('Server running on port 3000');
});
