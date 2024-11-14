const express = require("express")
const body_parser = require("body-parser")
require("dotenv").config()


const app = express()
const port = 3000;
app.use(body_parser.json())

app.use(body_parser.urlencoded({ extended: true }))

app.listen(port, () => {
    console.log(`Servidor en linea en el puerto ${port}`)
    console.log(`http://localhost:${port}`)
})

app.get("/", (req, res) => {
    res.status(200).json({ message: `En linea el en puerto ${port}` })
})

const { check_connection } = require("./queries")
app.get("/check", check_connection)


