-- -----------------------------------------------------
-- Schema transportadora
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `transportadora` ;

-- -----------------------------------------------------
-- Schema transportadora
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `transportadora` DEFAULT CHARACTER SET utf8 ;
USE `transportadora` ;

-- -----------------------------------------------------
-- Tabla `transportadora`.`tipo_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportadora`.`tipo_usuario` ;

CREATE TABLE IF NOT EXISTS `transportadora`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `tipo_usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `transportadora`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportadora`.`usuario` ;

CREATE TABLE IF NOT EXISTS `transportadora`.`usuario` (
  `cedula_usu` INT NOT NULL,
  `idtipo_usuario` INT NOT NULL,
  `nombre_usu` VARCHAR(45) NOT NULL,
  `apellido_usu` VARCHAR(45) NULL,
  `email_usu` VARCHAR(45) NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `direccion_usu` VARCHAR(100) NULL,
  `celular_usu` VARCHAR(14) NULL,
  PRIMARY KEY (`cedula_usu`),
  INDEX `fk_usuairo_tipo_usuario1_idx` (`idtipo_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuairo_tipo_usuario1`
    FOREIGN KEY (`idtipo_usuario`)
    REFERENCES `transportadora`.`tipo_usuario` (`idtipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `transportadora`.`conductor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportadora`.`conductor` ;

CREATE TABLE IF NOT EXISTS `transportadora`.`conductor` (
  `cedula_cond` INT NOT NULL,
  `nombre_cond` VARCHAR(45) NOT NULL,
  `email_cond` VARCHAR(45) NULL,
  `celular_cond` VARCHAR(14) NULL,
  `direccion_cond` VARCHAR(100) NULL,
  PRIMARY KEY (`cedula_cond`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `transportadora`.`ruta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportadora`.`ruta` ;

CREATE TABLE IF NOT EXISTS `transportadora`.`ruta` (
  `numero_ruta` INT NOT NULL AUTO_INCREMENT,
  `descripcion_ruta` VARCHAR(100) NOT NULL,
  `valor_pasaje` INT NOT NULL,
  PRIMARY KEY (`numero_ruta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `transportadora`.`bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportadora`.`bus` ;

CREATE TABLE IF NOT EXISTS `transportadora`.`bus` (
  `numero_bus` INT NOT NULL,
  `placa_bus` VARCHAR(6) NOT NULL,
  `numero_ruta` INT NOT NULL,
  PRIMARY KEY (`numero_bus`),
  INDEX `fk_bus_ruta1_idx` (`numero_ruta` ASC) VISIBLE,
  CONSTRAINT `fk_bus_ruta1`
    FOREIGN KEY (`numero_ruta`)
    REFERENCES `transportadora`.`ruta` (`numero_ruta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `transportadora`.`bus_conductor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportadora`.`bus_conductor` ;

CREATE TABLE IF NOT EXISTS `transportadora`.`bus_conductor` (
  `numero_bus` INT NOT NULL,
  `cedula_cond` INT NOT NULL,
  PRIMARY KEY (`numero_bus`, `cedula_cond`),
  INDEX `fk_bus_has_conductor_conductor1_idx` (`cedula_cond` ASC) VISIBLE,
  INDEX `fk_bus_has_conductor_bus1_idx` (`numero_bus` ASC) VISIBLE,
  CONSTRAINT `fk_bus_has_conductor_bus1`
    FOREIGN KEY (`numero_bus`)
    REFERENCES `transportadora`.`bus` (`numero_bus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_has_conductor_conductor1`
    FOREIGN KEY (`cedula_cond`)
    REFERENCES `transportadora`.`conductor` (`cedula_cond`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `transportadora`.`registro_diario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportadora`.`registro_diario` ;

CREATE TABLE IF NOT EXISTS `transportadora`.`registro_diario` (
  `idregistro_diario` INT NOT NULL AUTO_INCREMENT,
  `numero_bus` INT NOT NULL,
  `cedula_cond` INT NOT NULL,
  `cedula_usu` INT NOT NULL,
  `dia_laborado` DATE NOT NULL,
  `registro_inicial` INT UNSIGNED NOT NULL,
  `registro_final` INT UNSIGNED NOT NULL,
  `vlr_tanqueo` INT UNSIGNED NOT NULL,
  `vlr_parqueo` INT UNSIGNED NOT NULL,
  `vlr_lavado` INT UNSIGNED NOT NULL,
  `vlr_repuesto` INT UNSIGNED NOT NULL,
  `vlr_otros` INT UNSIGNED NOT NULL,
  `producido_dia` INT NOT NULL,
  `total_gastos_dia` INT NOT NULL,
  `ganancias_dia` INT NOT NULL,
  PRIMARY KEY (`idregistro_diario`),
  INDEX `fk_registro_diario_bus_conductor1_idx` (`numero_bus` ASC, `cedula_cond` ASC) VISIBLE,
  INDEX `fk_registro_diario_usuario1_idx` (`cedula_usu` ASC) VISIBLE,
  CONSTRAINT `fk_registro_diario_bus_conductor1`
    FOREIGN KEY (`numero_bus` , `cedula_cond`)
    REFERENCES `transportadora`.`bus_conductor` (`numero_bus` , `cedula_cond`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registro_diario_usuario1`
    FOREIGN KEY (`cedula_usu`)
    REFERENCES `transportadora`.`usuario` (`cedula_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
