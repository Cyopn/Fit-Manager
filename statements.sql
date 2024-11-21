-- Creacion de tablas
DROP TABLE IF EXISTS public."Miembro";

CREATE TABLE
    IF NOT EXISTS public."Miembro" (
        id_miembro serial NOT NULL,
        nombre text NOT NULL,
        apellido_paterno text NOT NULL,
        apellido_materno text NOT NULL,
        edad integer NOT NULL,
        correo_electronico text NOT NULL,
        telefono text NOT NULL,
        huella_dactilar bytea,
        CONSTRAINT "Miembro_pkey" PRIMARY KEY (id_miembro)
    );

DROP TABLE IF EXISTS public."Empleado";

CREATE TABLE
    IF NOT EXISTS public."Empleado" (
        id_empleado serial NOT NULL,
        nombre text NOT NULL,
        apellido_paterno text NOT NULL,
        apellido_materno text NOT NULL,
        edad integer NOT NULL,
        correo_electronico text NOT NULL,
        usuario text NOT NULL,
        "contraseña" text NOT NULL,
        puesto text NOT NULL,
        CONSTRAINT "Empleado_pkey" PRIMARY KEY (id_empleado)
    );

DROP TABLE IF EXISTS public."Producto";

CREATE TABLE
    IF NOT EXISTS public."Producto" (
        id_producto serial NOT NULL,
        nombre text NOT NULL,
        marca text NOT NULL,
        descripcion text NOT NULL,
        precio double precision NOT NULL,
        inventario integer NOT NULL,
        CONSTRAINT "Producto_pkey" PRIMARY KEY (id_producto)
    );

DROP TABLE IF EXISTS public."Equipo";

CREATE TABLE
    IF NOT EXISTS public."Equipo" (
        id_equipo serial NOT NULL,
        nombre text NOT NULL,
        marca text NOT NULL,
        descripcion text NOT NULL,
        id_empleado serial NOT NULL,
        CONSTRAINT "Equipo_pkey" PRIMARY KEY (id_equipo),
        CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES public."Empleado" (id_empleado) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
    );

DROP TABLE IF EXISTS public."Suscripcion";

CREATE TABLE
    IF NOT EXISTS public."Suscripcion" (
        id_suscripcion serial NOT NULL,
        fecha_inicio date NOT NULL,
        fecha_fin date NOT NULL,
        estado text NOT NULL,
        id_miembro serial NOT NULL,
        id_empleado serial NOT NULL,
        CONSTRAINT "Suscripcion_pkey" PRIMARY KEY (id_suscripcion),
        CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES public."Empleado" (id_empleado) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
        CONSTRAINT fk_miembro FOREIGN KEY (id_miembro) REFERENCES public."Miembro" (id_miembro) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
    );

DROP TABLE IF EXISTS public."Venta";

CREATE TABLE
    IF NOT EXISTS public."Venta" (
        id_venta serial NOT NULL,
        total double precision NOT NULL,
        fecha date NOT NULL,
        CONSTRAINT "Venta_pkey" PRIMARY KEY (id_venta)
    );

DROP TABLE IF EXISTS public."Venta_Producto";

CREATE TABLE
    IF NOT EXISTS public."Venta_Producto" (
        id_venta_producto serial NOT NULL,
        cantidad integer NOT NULL,
        id_venta serial NOT NULL,
        id_producto serial NOT NULL,
        CONSTRAINT "Venta_Producto_pkey" PRIMARY KEY (id_venta_producto),
        CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES public."Producto" (id_producto) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
        CONSTRAINT fk_venta FOREIGN KEY (id_venta) REFERENCES public."Venta" (id_venta) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
    );

-- Insert
INSERT INTO
    public."Miembro" (
        nombre,
        apellido_paterno,
        apellido_materno,
        edad,
        correo_electronico,
        telefono
    )
VALUES
    (
        "Pablo",
        "Perez",
        "Suarez",
        21,
        "pabloperezsuarez@gmail.com",
        "5585239808"
    ),
    (
        "Fernando",
        "Ramirez",
        "Acosta",
        21,
        "fernandoramirezacosta@gmail.com",
        "5552335799"
    ),
    (
        "Juan Antonio",
        "Calvillo",
        "Benitez",
        21,
        "juan antoniocalvillobenitez@gmail.com",
        "5500868057"
    ),
    (
        "Adrian",
        "Sanchez",
        "Mendiola",
        21,
        "adriansanchezmendiola@gmail.com",
        "5559339133"
    ),
    (
        "Jesus Alexis",
        "Urquiza",
        "Luis",
        21,
        "jesus alexisurquizaluis@gmail.com",
        "5541766240"
    );

INSERT INTO
    public."Empleado" (
        nombre,
        apellido_paterno,
        apellido_materno,
        edad,
        correo_electronico,
        usuario,
        "contraseña",
        puesto
    )
VALUES
    (
        'Pablo',
        'Calvillo',
        'Luis',
        21,
        'pablocalvilloluis@gmail.com',
        'pablocal',
        'luis21',
        'Adminstrador'
    ),
    (
        'Fernando',
        'Sanchez',
        'Suarez',
        21,
        'fernandosanchezsuarez@gmail.com',
        'fernandosan',
        'suarez21',
        'Empleado'
    ),
    (
        'Juan Antonio',
        'Urquiza',
        'Acosta',
        21,
        'juan antoniourquizaacosta@gmail.com',
        'juan antoniourq',
        'acosta21',
        'Empleado '
    ),
    (
        'Adrian',
        'Perez',
        'Benitez',
        21,
        'adrianperezbenitez@gmail.com',
        'adrianper',
        'benitez21',
        'Administrador'
    ),
    (
        'Jesus Alexis',
        'Ramirez',
        'Mendiola',
        21,
        'jesus alexisramirezmendiola@gmail.com',
        'jesus alexisram',
        'mendiola21',
        'Empleado'
    );

INSERT INTO
    public."Producto" (nombre, marca, descripcion, precio, inventario)
VALUES
    (
        'Polvo de Proteína Sabor Vainilla Horchata',
        'Sascha Fitness',
        'Proteína aislada de suero de leche hidrolizada, cero carbohidratos, cero azúcares, cero. grasas.',
        1239,
        10
    ),
    (
        'Creatina Monohidratada Sin Sabor',
        'Nutrex',
        'No tiene sabor por lo que puede ser adicionada a su bebida favorita, ideal para consumo diario.',
        649,
        10
    ),
    (
        'REVIVE 750ml',
        'SmartShake',
        'REVIVE de SmartShake está diseñado para mantenerte hidratado e ir al GYM. Cuenta con el asa suave y detalles de goma, que lo hacen fácil de llevar y sostener.',
        280,
        10
    ),
    (
        '2 Pack Quest Crackers sabor Queso Cheddar Explosivo',
        'Quest Nutrition',
        '10 g de proteína, 5 g de carbohidratos, Caja con 4 bolsas de 30 g sabor a Queso Cheddar. Explosivo',
        429,
        10
    ),
    (
        'Guantes de entrenamiento Elite Verde',
        'Adidas',
        'Diseñados para un rendimiento de alto nivel, los guantes de entrenamiento adidas Elite ofrecen total comodidad y agarre, fomentando un mayor rendimiento en cada repetición.',
        719,
        10
    ),
    (
        'Quest Chips horneadas de proteína sabor Salsa Roja',
        'Quest Nutrition',
        'Caja con 8 bolsas de 32 g sabor Salsa Roja.',
        529,
        10
    ),
    (
        'Rodillera Deportiva',
        'Adidas',
        'Permitiéndote seguir avanzando con tu entrenamiento, la rodillera tejida de adidas ayuda a mantenerte en movimiento y progresando durante períodos de entrenamiento exigentes.',
        479,
        10
    ),
    (
        'Soporte deportivo para tobillo',
        'Adidas',
        'El soporte deportivo para tobillo Adidas ha sido diseñado para adaptarse a la curvatura natural de la articulación y ofrecer soporte sin restringir el movimiento o la comodidad, por lo que es ideal para actividades deportivas y de entrenamiento.',
        299,
        10
    ),
    (
        'Galleta sabor Doble Chocolate',
        'Lenny & Larry´s',
        'Si amas el chocolate tanto como a nosotros, te encantarán nuestras galletas de doble chocolate a base de plantas. Espolvoreadas con chispas con chispas de chocolate semidulce para tener la mega-dosis de chocolate que has estado buscando.',
        479,
        10
    );

INSERT INTO
    public."Equipo" (nombre, marca, descripcion, id_empleado)
VALUES
    (
        'Banca para pesas GP 1920',
        'Gimpack',
        'Con la banca GP 1920 podrás trabajar con todo tipo de barras y discos gracias a su diseño hecho con materiales sólidos y resistentes, obtén mayor comodidad con su asiento acojinable y antideslizante, además, cuenta con 4 posiciones de inclinación que te ayudan a maximizar los resultados de tu entrenamiento.',
        1020571819406884865
    ),
    (
        'Gimnasio de una estación GP 2920',
        'Gimpack',
        'El gimnasio GP 2920 te permite ejercitar los principales grupos musculares como pierna, brazo, hombro y abdomen en la comodidad de tu hogar.',
        1020571819406983169
    ),
    (
        'Banca Multifuncional GP 922',
        'Gimpack',
        'La banca multifuncional GP 922 cuenta con predicador, extensión de pierna y 6 posiciones de inclinación en el respaldo, su asiento y predicador son ajustables en 3 diferentes niveles para una variedad de opciones de entrenamiento óptimo y completo.',
        1020571819407015937
    ),
    (
        'Discos para Pesas',
        'Gimpack',
        'Dimensiones: Diámetro: 29 cm / Alto: 3 cm, Pesos: 10.0 kg.',
        1020571819407048705
    ),
    (
        'Barra para Pesas',
        'Gimpack',
        'Hecha para recibir discos de pesas con diámetro interior de una pulgada, el diseño facilita la mayoría de los ejercicios ayudando a concentrar el esfuerzo en los músculos deseados.',
        1020571819407081473
    ),
    (
        'CINTA DE CORRER CON INCLINACIÓN AUTOMÁTICA PWG-SF-T7705',
        'Sunny Health and Fitness',
        'Experimente 15 niveles de inclinación automática y opciones de velocidad de hasta 9 mph para un régimen personalizado que mejor se adapte a sus objetivos de acondicionamiento físico únicos.',
        1020571819407015937
    ),
    (
        'PRENSA DE PIERNAS 45° PW-3001',
        'Power Fitness',
        'Tamaño: 1.45 x 2.10 x 1.38 m. Peso: 190 kg.',
        1020571819407048705
    ),
    (
        'REAL DELT/PEC FLY',
        'Power Fitness',
        '1.24*94*2.10 M 227 KG 80 KG.',
        1020571819406884865
    ),
    (
        'BODY SOLID BANCO OLIMPICO PLANO PWG-SOFB250',
        'Power Fitness',
        'Maquina de pecho comercial.',
        1020571819406983169
    ),
    (
        'Contractor de pecho E02 PWG-E02',
        'Power Fitness',
        'Contractor de pecho / Butterfly (95 kg).',
        1020571819407081473
    );


-- Obtener ultima fila 
SELECT
    *
FROM
    public."Venta"
ORDER BY
    fecha DESC
LIMIT
    1;

INSERT INTO
    public."Venta" (total, fecha)
VALUES
    (?, ?);