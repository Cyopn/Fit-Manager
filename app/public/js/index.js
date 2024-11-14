const url_request = 'http://localhost:3000/';

const links = document.querySelectorAll('.nav-link');
if (links.length) {
    links.forEach((link) => {
        link.addEventListener('click', (e) => {
            links.forEach((link) => {
                link.classList.remove('active');
            });
            link.classList.add('active');
        });
    });
}

async function login() {
    const username = document.getElementById('user').value
    const password = document.getElementById('password').value
    console.log(username, password)
    try {
        const response = await fetch(`${url_request}login`, { method: 'POST', headers: { "Content-Type": "application/json" }, body: JSON.stringify({ username, password }) })
        const data = await response.json()
        if (data.auth) {
            window.location.href = '/dashboard'
        } else {
            alert('Usuario o contraseña incorrectos')
        }
        console.log(data)
    } catch (err) {
        console.log(err)
    }
}