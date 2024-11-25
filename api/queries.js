const { Pool } = require("pg");
const pool = new Pool({ connectionString: process.env.database_url });
require("dotenv").config()

const check_connection = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: 'Error al crear cliente', data: err })
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
        if (err) return res.status(500).json({ message: 'Error al crear cliente', data: err })
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
        if (err) return res.status(500).json({ message: 'Error al crear cliente', data: err })
        client.query(`INSERT INTO public."Miembro" (nombre, apellido_paterno, apellido_materno, edad, correo_electronico, telefono) VALUES ('${nombre}', '${apellido_paterno}', '${apellido_materno}', ${edad}, '${correo_electronico}', '${telefono}');`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: 'Error al guardar usuario', data: err });
            res.status(200).json({ message: 'Usuario guardado', data: result });
        })
    })
}

const get_products = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear cliente", data: err })
        client.query(`SELECT * FROM public."Producto";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener productos", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })

    })
}

const get_equipment = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear cliente", data: err })
        client.query(`SELECT * FROM public."Equipo";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener equipo", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })
    })
}

const get_member = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear cliente", data: err })
        client.query(`SELECT * FROM public."Miembro";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener miembros", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })
    })
}

const get_employee = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear cliente", data: err })
        client.query(`SELECT * FROM public."Empleado";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener miembros", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })
    })
}

const get_subscription = async (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear cliente", data: err })
        client.query(`SELECT * FROM public."Suscripcion";`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al obtener suscripciones", data: err })
            res.status(200).json({ message: "Consulta correcta", data: result.rows })
        })
    })
}

const add_sale = async (req, res) => {
    const { total, ventas } = req.body
    pool.connect(function (err, client, done) {
        if (err) return res.status(500).json({ message: "Error al crear cliente", data: err })
        client.query(`INSERT INTO public."Venta" (total, fecha) VALUES (${total}, (SELECT NOW()));`, function (err, result) {
            done()
            if (err) return res.status(500).json({ message: "Error al agregar venta a tabla venta", data: err })
            pool.connect(function (err, client, done) {
                if (err) return res.status(500).json({ message: "Error al crear cliente", data: err })
                client.query(`SELECT * FROM public."Venta" ORDER BY fecha DESC LIMIT 1;`, async function (err, result) {
                    done()
                    if (err) return res.status(500).json({ message: "Error al obtener ultimo registro en tabla ventas", data: err })
                    try {
                        await add_product_per_sale(result.rows[0].id_venta, ventas)
                        await sub_inventory(ventas)
                    } catch (e) {
                        return res.status(500).json({ message: "Error al agregar/actualizar venta en tabla venta_producto/producto", data: e })
                    }
                    res.status(200).json({ message: "Venta agregada", data: result })
                })
            })
        })
    })
}

const add_product_per_sale = async (id_venta, sales) => {
    let values = ""
    for (let i = 0; i < sales.length; i++) {
        if (i === (sales.length - 1)) {
            values += `(${sales[i].cantidad}, ${id_venta}, ${sales[i].id_producto})`
        } else {
            values += `(${sales[i].cantidad}, ${id_venta}, ${sales[i].id_producto}), `
        }
    }
    pool.connect(function (err, client, done) {
        if (err) return err
        client.query(`INSERT INTO public."Venta_Producto" (cantidad, id_venta, id_producto) VALUES ${values};`, async function (err, result) {
            done()
            if (err) return err
        })
    })
}

const sub_inventory = async (sales) => {
    sales.forEach(e => {
        pool.connect(function (err, client, done) {
            if (err) return err
            client.query(`UPDATE public."Producto" SET inventario = inventario - ${e.cantidad} WHERE id_producto = ${e.id_producto};`, async function (err, result) {
                done()
                if (err) return err
            })
        })
    });
}

module.exports = {
    check_connection,
    login,
    save_user,
    get_products,
    get_equipment,
    get_member,
    get_employee,
    get_subscription,
    add_sale
}