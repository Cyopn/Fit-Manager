const url_request = 'http://localhost:5000/';

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
    try {
        const response = await fetch(`${url_request}login`, { method: 'POST', headers: { "Content-Type": "application/json" }, body: JSON.stringify({ username, password }) })
        const data = await response.json()
        if (data.auth) {
            window.location.href = '/dashboard'
        } else {
            alert('Usuario o contraseña incorrectos')
        }
    } catch (err) {
        console.log(err)
    }
}

const diasFestivos = [
    "01-01", "02-05", "03-18", "05-01", "09-16", "11-20", "12-25"
];

const horariosPorDia = {
    lunes: "Horario: 6:00 AM - 10:00 PM",
    martes: "Horario: 6:00 AM - 10:00 PM",
    miercoles: "Horario: 6:00 AM - 10:00 PM",
    jueves: "Horario: 6:00 AM - 10:00 PM",
    viernes: "Horario: 6:00 AM - 10:00 PM",
    sabado: "Horario: 7:00 AM - 2:00 PM",
    domingo: "Horario: 8:00 AM - 12:00 PM"
};

const calendarContainer = document.querySelector('.calendar');
const serviceInfoDiv = document.getElementById('service-info');
const monthYearDisplay = document.getElementById('monthYear');
let currentMonth = new Date().getMonth();
let currentYear = new Date().getFullYear();

function update_month_year_display() {
    const monthNames = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    monthYearDisplay.textContent = `${monthNames[currentMonth]} ${currentYear}`;
}

function obtenerHorarioServicio(fecha) {
    const [year, month, day] = fecha.split("-").map(Number);
    const mesDia = `${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    if (diasFestivos.includes(mesDia)) {
        return "No hay servicio en días festivos.";
    }
    const date = new Date(year, month - 1, day);
    const diasSemana = ["domingo", "lunes", "martes", "miercoles", "jueves", "viernes", "sabado"];
    const dia = diasSemana[date.getDay()];
    return horariosPorDia[dia];
}

function generate_calendar() {
    calendarContainer.innerHTML = `
        <div class="calendar-day">Lun</div>
        <div class="calendar-day">Mar</div>
        <div class="calendar-day">Mié</div>
        <div class="calendar-day">Jue</div>
        <div class="calendar-day">Vie</div>
        <div class="calendar-day">Sáb</div>
        <div class="calendar-day">Dom</div>
    `;

    const firstDay = new Date(currentYear, currentMonth, 1).getDay();
    const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
    const offset = (firstDay + 6) % 7;

    for (let i = 0; i < offset; i++) {
        calendarContainer.innerHTML += `<div></div>`;
    }

    for (let day = 1; day <= daysInMonth; day++) {
        const dayElement = document.createElement('div');
        dayElement.className = 'day';
        dayElement.textContent = day;
        dayElement.addEventListener('click', () => {
            const selectedDate = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
            const horario = obtenerHorarioServicio(selectedDate);
            serviceInfoDiv.style.display = 'block';
            serviceInfoDiv.innerHTML = `<strong>Día ${day}:</strong> ${horario}`;
        });
        calendarContainer.appendChild(dayElement);
    }
}

document.getElementById('prevMonth').addEventListener('click', () => {
    currentMonth--;
    if (currentMonth < 0) {
        currentMonth = 11;
        currentYear--;
    }
    update_month_year_display();
    generate_calendar();
});

document.getElementById('nextMonth').addEventListener('click', () => {
    currentMonth++;
    if (currentMonth > 11) {
        currentMonth = 0;
        currentYear++;
    }
    update_month_year_display();
    generate_calendar();
});

update_month_year_display();
generate_calendar();

var element = document.getElementById('map');
var map = L.map(element);

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);
var target = L.latLng('47.50737', '19.04611');
map.setView(target, 14);
L.marker(target).addTo(map);

async function save_user() {
    const nombre = document.getElementById("name").value
    const apellido_paterno = document.getElementById("last_f").value
    const apellido_materno = document.getElementById("last_m").value
    const edad = document.getElementById("age").value
    const correo_electronico = document.getElementById("email").value
    const telefono = document.getElementById("phone").value
    try {
        const response = await fetch(`${url_request}save_user`, { method: 'POST', headers: { "Content-Type": "application/json" }, body: JSON.stringify({ nombre, apellido_paterno, apellido_materno, edad, correo_electronico, telefono }) })
        const data = await response.json()
        window.alert(data.message)
    } catch (e) {
        console.log(e)
    }
}