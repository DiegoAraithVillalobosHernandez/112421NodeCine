const mysql = require('mysql');
const {promisify} = require('util')
const {database} = require('./keys.js');

const pool = mysql.createPool(database);

pool.getConnection((err,conn) => {
    if(err){
        if(err.code === 'PROTOCOL_CONNECTION_LOST'){
            console.log("DATABASE WAS CLOSED");
        }
        if(err.code === 'ER_CON_COUNT_ERROR'){
            console.log("DATABASE HAS TO MANY CONNECTIONS");
        }
        if(err.code === 'ECONNREFUSED'){
            console.log("DABABASE CONNECTION REFUSED");
        }
    }
    if(conn) conn.release();
    console.log("DABABASE IS CONNECTED");
    return;
});

// enable promises
pool.query = promisify(pool.query);
module.exports = pool;