
const check_connection = (req, res) => {
    res.status(200).json({ message: 'Conectado' });
}



module.exports = {
    check_connection
}

