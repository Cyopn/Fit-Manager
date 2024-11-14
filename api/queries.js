const { Client } = require("pg");
require("dotenv").config()
const client = new Client(process.env.database_url);

const check_connection = async (req, res) => {
    await client.connect();
    try {
        const results = await client.query("SELECT NOW()");
        console.log(results.rows);
        res.status(200).json({ message: 'Conectado', data: results.rows  });
    } catch (err) {
        res.status(500).json({ message: 'Error', data: err });
        console.error("error executing query:", err);
    } finally {
        client.end();
    }

}



module.exports = {
    check_connection
}