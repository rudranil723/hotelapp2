const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Create a connection to the database
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Ruddy@1234',
  database: 'hotel_management'
});

// Connect to the database
db.connect(err => {
  if (err) {
    console.error('Error connecting to the database:', err);
    return;
  }
  console.log('Connected to the database.');
});

// Define API endpoints

// Get all employees
app.get('/employees', (req, res) => {
  db.query('SELECT * FROM employees', (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

// Get all rooms
app.get('/rooms', (req, res) => {
  db.query('SELECT * FROM rooms', (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

// Add a new employee
app.post('/employees', (req, res) => {
  const { username, password, auth_key } = req.body;
  db.query('INSERT INTO employees SET ?', { username, password, auth_key }, (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(201).send(results);
  });
});

// Add a new room
app.post('/rooms', (req, res) => {
  const { room_number } = req.body;
  db.query('INSERT INTO rooms SET ?', { room_number }, (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(201).send(results);
  });
});

// Update room booking status
app.put('/rooms/:id', (req, res) => {
  const { id } = req.params;
  const { check_in_date, check_out_date, booked } = req.body;
  db.query(
    'UPDATE rooms SET check_in_date = ?, check_out_date = ?, booked = ? WHERE id = ?',
    [check_in_date, check_out_date, booked, id],
    (err, results) => {
      if (err) {
        return res.status(500).send(err);
      }
      res.send(results);
    }
  );
});

// Login endpoint
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  db.query('SELECT * FROM employees WHERE username = ?', [username], (err, results) => {
    if (err) {
      return res.status(500).send({
        status: 'error',
        message: 'Database query error',
      });
    }
    if (results.length === 0) {
      return res.status(401).send({
        status: 'error',
        message: 'Invalid credentials',
      });
    }
    const user = results[0];
    if (password != user.password) {
      return res.status(401).send({
        status: 'error',
        message: 'Invalid credentials',
      });
    }
    res.send({
      status: 'success',
      auth_key: user.auth_key,
      employee_id: user.id,
    });
  });
});

// Get unavailable dates for a user by employee ID
app.get('/unavailable_dates/:employee_id', (req, res) => {
  const { employee_id } = req.params;
  db.query(`
    SELECT available_date
    FROM employee_dates
    WHERE employee_id = ?
  `, [employee_id], (err, results) => {
    if (err) {
      return res.status(500).send({
        status: 'error',
        message: 'Database query error',
      });
    }
    res.send(results);
  });
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
