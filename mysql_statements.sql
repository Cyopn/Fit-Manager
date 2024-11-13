-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Gimnasio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Gimnasio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Gimnasio` DEFAULT CHARACTER SET utf8 ;
USE `Gimnasio` ;

-- -----------------------------------------------------
-- Table `Gimnasio`.`Miembro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gimnasio`.`Miembro` (
  `idMiembro` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `ApellidoPatetrno` VARCHAR(45) NOT NULL,
  `ApellidoMaterno` VARCHAR(45) NOT NULL,
  `Edad` INT NOT NULL,
  `CorreoElectronico` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `HuellaDactilar` BLOB NOT NULL,
  PRIMARY KEY (`idMiembro`),
  UNIQUE INDEX `idMiembo_UNIQUE` (`idMiembro` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gimnasio`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gimnasio`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `ApellidoPatetrno` VARCHAR(45) NOT NULL,
  `ApellidoMaterno` VARCHAR(45) NOT NULL,
  `Edad` INT NOT NULL,
  `CorreoElectronico` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  `Contraseña` VARCHAR(45) NOT NULL,
  `Puesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE INDEX `idMiembo_UNIQUE` (`idEmpleado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gimnasio`.`Suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gimnasio`.`Suscripcion` (
  `idSuscripcion` INT NOT NULL AUTO_INCREMENT,
  `FechaInicio` DATE NOT NULL,
  `FechaFin` DATE NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Miembro_idMiembro` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idSuscripcion`, `Miembro_idMiembro`, `Empleado_idEmpleado`),
  INDEX `fk_Suscripcion_Miembro_idx` (`Miembro_idMiembro` ASC) VISIBLE,
  UNIQUE INDEX `idSuscripcion_UNIQUE` (`idSuscripcion` ASC) VISIBLE,
  INDEX `fk_Suscripcion_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gimnasio`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gimnasio`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Descripcion` TEXT NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  `Inventario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProducto`),
  UNIQUE INDEX `idProducto_UNIQUE` (`idProducto` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gimnasio`.`Equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gimnasio`.`Equipo` (
  `idEquipo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idEquipo`, `Empleado_idEmpleado`),
  UNIQUE INDEX `idEquipo_UNIQUE` (`idEquipo` ASC) VISIBLE,
  INDEX `fk_Equipo_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gimnasio`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gimnasio`.`Venta` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `Total` DECIMAL(10,2) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Miembro_idMiembro` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idVenta`, `Miembro_idMiembro`, `Empleado_idEmpleado`),
  UNIQUE INDEX `idVenta_UNIQUE` (`idVenta` ASC) VISIBLE,
  INDEX `fk_Venta_Miembro1_idx` (`Miembro_idMiembro` ASC) VISIBLE,
  INDEX `fk_Venta_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gimnasio`.`VentaProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gimnasio`.`VentaProducto` (
  `idVentaProducto` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `Venta_idVenta` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`idVentaProducto`, `Venta_idVenta`, `Producto_idProducto`),
  UNIQUE INDEX `idVentaProducto_UNIQUE` (`idVentaProducto` ASC) VISIBLE,
  INDEX `fk_VentaProducto_Venta1_idx` (`Venta_idVenta` ASC) VISIBLE,
  INDEX `fk_VentaProducto_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;