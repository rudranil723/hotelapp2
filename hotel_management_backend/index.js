require('dotenv').config();

const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

db.connect(err => {
  if (err) {
    console.error('Error connecting to the database:', err);
    return;
  }
  console.log('Connected to the database.');
});

app.get('/employees', (req, res) => {
  db.query('SELECT * FROM employees', (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

app.get('/rooms', (req, res) => {
  db.query('SELECT * FROM rooms', (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

app.post('/employees', (req, res) => {
  const { username, password, auth_key } = req.body;
  db.query('INSERT INTO employees SET ?', { username, password, auth_key }, (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(201).send(results);
  });
});

app.post('/rooms', (req, res) => {
  const { room_number } = req.body;
  db.query('INSERT INTO rooms SET ?', { room_number }, (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(201).send(results);
  });
});

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

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
