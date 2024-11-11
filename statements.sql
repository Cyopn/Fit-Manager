-- Creacion de tablas

DROP TABLE IF EXISTS public."Miembro";

CREATE TABLE IF NOT EXISTS public."Miembro"
(
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

CREATE TABLE IF NOT EXISTS public."Empleado"
(
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

CREATE TABLE IF NOT EXISTS public."Producto"
(
    id_producto serial NOT NULL,
    nombre text NOT NULL,
    marca text NOT NULL,
    descripcion text NOT NULL,
    precio double precision NOT NULL,
    inventario integer NOT NULL,
    CONSTRAINT "Producto_pkey" PRIMARY KEY (id_producto)
);

DROP TABLE IF EXISTS public."Equipo";

CREATE TABLE IF NOT EXISTS public."Equipo"
(
    id_equipo serial NOT NULL,
    nombre text NOT NULL,
    marca text NOT NULL,
    descripcion text NOT NULL,
    id_empleado serial NOT NULL,
    CONSTRAINT "Equipo_pkey" PRIMARY KEY (id_equipo),
    CONSTRAINT fk_empleado FOREIGN KEY (id_empleado)
        REFERENCES public."Empleado" (id_empleado) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

DROP TABLE IF EXISTS public."Suscripcion";

CREATE TABLE IF NOT EXISTS public."Suscripcion"
(
    id_suscripcion serial NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    estado text NOT NULL,
    id_miembro serial NOT NULL,
    id_empleado serial NOT NULL,
    CONSTRAINT "Suscripcion_pkey" PRIMARY KEY (id_suscripcion),
    CONSTRAINT fk_empleado FOREIGN KEY (id_empleado)
        REFERENCES public."Empleado" (id_empleado) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_miembro FOREIGN KEY (id_miembro)
        REFERENCES public."Miembro" (id_miembro) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

DROP TABLE IF EXISTS public."Venta";

CREATE TABLE IF NOT EXISTS public."Venta"
(
    id_venta bigint NOT NULL,
    total double precision NOT NULL,
    fecha date NOT NULL,
    CONSTRAINT "Venta_pkey" PRIMARY KEY (id_venta)
);

DROP TABLE IF EXISTS public."Venta_Producto";

CREATE TABLE IF NOT EXISTS public."Venta_Producto"
(
    id_venta_producto serial NOT NULL,
    cantidad integer NOT NULL,
    id_venta serial NOT NULL,
    id_producto serial NOT NULL,
    CONSTRAINT "Venta_Producto_pkey" PRIMARY KEY (id_venta_producto),
    CONSTRAINT fk_producto FOREIGN KEY (id_producto)
        REFERENCES public."Producto" (id_producto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_venta FOREIGN KEY (id_venta)
        REFERENCES public."Venta" (id_venta) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ypvOnptjQV2s2ia1WiiRAA