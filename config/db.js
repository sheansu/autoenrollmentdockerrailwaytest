// config/db.js
const mysql = require('mysql2');

const dbConfig = {
  host:     process.env.MYSQLHOST     || process.env.DB_HOST     || 'localhost',
  user:     process.env.MYSQLUSER     || process.env.DB_USER     || 'root',
  password: process.env.MYSQLPASSWORD || process.env.DB_PASSWORD || '',
  database: process.env.MYSQLDATABASE || process.env.DB_NAME     || 'ced_preenrollment',
  port:     process.env.MYSQLPORT     || process.env.DB_PORT     || 3306,
};

const db = mysql.createPool(dbConfig);

db.getConnection((err, conn) => {
  if (err) return console.error('DB connection FAILED:', err.code, err.message);
  console.log(`DB connected to ${dbConfig.host}:${dbConfig.port}/${dbConfig.database}`);
  conn.release();
});

module.exports = db;