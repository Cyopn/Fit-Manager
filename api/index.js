const express = require("express")
const body_parser = require("body-parser")
const cors = require("cors")
require("dotenv").config()


const app = express()
const port = 5000;
app.use(body_parser.json())

app.use(body_parser.urlencoded({ extended: true }))

app.use(cors({ origin: true, credentials: false }));

app.use(cors({
    origin: "http://localhost:4000",
    methods: ["POST", "GET"]
}));


app.listen(port, () => {
    console.log(`Servidor en linea en http://localhost:${port}`)
})

app.get("/", (req, res) => {
    res.status(200).json({ message: `En linea el en puerto ${port}` })
})

const { check_connection, login, save_user, get_products, get_equipment, get_member } = require("./queries")
app.get("/check", check_connection)
app.post("/login", login)
app.post("/save_user", save_user)
app.get("/get_products", get_products)
app.get("/get_equipment", get_equipment)
app.get("/get_member", get_member)
