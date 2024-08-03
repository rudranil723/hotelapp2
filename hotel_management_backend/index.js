// require('dotenv').config();  // Ensure dotenv is required at the top of your file

// const express = require('express');
// const { Client } = require('pg');
// const bodyParser = require('body-parser');
// const cors = require('cors');

// const app = express();
// app.use(bodyParser.json());
// app.use(cors());

// const db = new Client({
//   connectionString: process.env.DATABASE_URL,  // Use the DATABASE_URL from the .env file
//   ssl: {
//     rejectUnauthorized: false,
//   },
// });

// db.connect(err => {
//   if (err) {
//     console.error('Error connecting to the database:', err);
//     return;
//   }
//   console.log('Connected to the database.');
// });

// app.get('/employees', (req, res) => {
//   db.query('SELECT * FROM employees', (err, results) => {
//     if (err) {
//       return res.status(500).send(err);
//     }
//     res.json(results.rows);
//   });
// });

// app.get('/rooms', (req, res) => {
//   db.query('SELECT * FROM rooms', (err, results) => {
//     if (err) {
//       return res.status(500).send(err);
//     }
//     res.json(results.rows);
//   });
// });

// app.post('/employees', (req, res) => {
//   const { username, password, auth_key } = req.body;
//   db.query(
//     'INSERT INTO employees (username, password, auth_key) VALUES ($1, $2, $3)',
//     [username, password, auth_key],
//     (err, results) => {
//       if (err) {
//         return res.status(500).send(err);
//       }
//       res.status(201).send(results);
//     }
//   );
// });

// app.post('/rooms', (req, res) => {
//   const { room_number } = req.body;
//   db.query(
//     'INSERT INTO rooms (room_number) VALUES ($1)',
//     [room_number],
//     (err, results) => {
//       if (err) {
//         return res.status(500).send(err);
//       }
//       res.status(201).send(results);
//     }
//   );
// });

// app.put('/rooms/:id', (req, res) => {
//   const { id } = req.params;
//   const { check_in_date, check_out_date, booked } = req.body;
//   db.query(
//     'UPDATE rooms SET check_in_date = $1, check_out_date = $2, booked = $3 WHERE id = $4',
//     [check_in_date, check_out_date, booked, id],
//     (err, results) => {
//       if (err) {
//         return res.status(500).send(err);
//       }
//       res.send(results);
//     }
//   );
// });

// app.post('/login', (req, res) => {
//   const { username, password } = req.body;
//   db.query('SELECT * FROM employees WHERE username = $1', [username], (err, results) => {
//     if (err) {
//       return res.status(500).send({
//         status: 'error',
//         message: 'Database query error',
//       });
//     }
//     if (results.rows.length === 0) {
//       return res.status(401).send({
//         status: 'error',
//         message: 'Invalid credentials',
//       });
//     }
//     const user = results.rows[0];
//     if (password !== user.password) {
//       return res.status(401).send({
//         status: 'error',
//         message: 'Invalid credentials',
//       });
//     }
//     res.send({
//       status: 'success',
//       auth_key: user.auth_key,
//       employee_id: user.id,
//     });
//   });
// });

// app.get('/unavailable_dates/:employee_id', (req, res) => {
//   const { employee_id } = req.params;
//   db.query('SELECT available_date FROM employee_dates WHERE employee_id = $1', [employee_id], (err, results) => {
//     if (err) {
//       return res.status(500).send({
//         status: 'error',
//         message: 'Database query error',
//       });
//     }
//     res.send(results.rows);
//   });
// });

// const PORT = 3000;
// app.listen(PORT, () => {
//   console.log(`Server is running on port ${PORT}`);
// });

require('dotenv').config(); // Ensure this is at the top

const { Client } = require('pg');

// Log the database URL to verify it's loaded correctly
console.log('Database URL:', process.env.DATABASE_URL);

const client = new Client({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

client.connect()
  .then(() => console.log('Connected to the database.'))
  .catch(err => console.error('Error connecting to the database:', err));
