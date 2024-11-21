const { Client, Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.database_url });
require("dotenv").config()

const check_connection = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: 'Error al crear conexion', data: err })
        client.query("SELECT NOW()", function (err, result) {
            done();
            if (err) return res.status(500).json({ message: 'Error al realizar consulta', data: err });
            res.status(200).json({ message: 'Consulta exitosa', data: result.rows });
        });
    });
}

const login = async (req, res) => {
    const { username, password } = req.body;
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: 'Error al crear conexion', data: err })
        client.query(`SELECT * FROM public."Empleado" WHERE usuario = '${username}' and contraseña = '${password}';`, function (err, result) {
            done();
            if (err) return res.status(500).json({ message: 'Error al realizar consulta', data: err });
            if (result.rows.length < 1) return res.status(401).json({ message: 'No autorizado', auth: false });
            res.status(200).json({ message: 'Autorizado', auth: true });
        });
    });
}

const save_user = async (req, res) => {
    const { nombre, apellido_paterno, apellido_materno, edad, correo_electronico, telefono } = req.body
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: 'Error al crear conexion', data: err })
        client.query(`INSERT INTO public."Miembro" (nombre, apellido_paterno, apellido_materno, edad, correo_electronico, telefono) VALUES ('${nombre}', '${apellido_paterno}', '${apellido_materno}', ${edad}, '${correo_electronico}', '${telefono}');`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: 'Error al guardar usuario', data: err });
            res.status(200).json({ message: 'Usuario guardado', data: result });
        })
    })
}

const get_products = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear conexion", data: err })
        client.query(`SELECT * FROM public."Producto";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener productos", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })

    })
}

const get_equipment = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear conexion", data: err })
        client.query(`SELECT * FROM public."Equipo";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener equipo", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })
    })
}

const get_member = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear conexion", data: err })
        client.query(`SELECT * FROM public."Miembro";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener miembros", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })
    })
}

const get_employee = async (req, res) => {
    pool.connect(function (err, client, done) {

    })
}

module.exports = {
    check_connection,
    login,
    save_user,
    get_products,
    get_equipment,
    get_member
}