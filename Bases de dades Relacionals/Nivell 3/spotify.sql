-- MySQL Workbench Synchronization
-- Generated: 2021-07-03 19:05
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Pol Farreny Capdevila

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `spotify`.`USUARI` (
  `id_usuari` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `contrasenya` VARCHAR(20) NOT NULL,
  `nom_usuari` VARCHAR(20) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` VARCHAR(10) NULL DEFAULT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `codi_postal` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_usuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`USUARI_FREE` (
  `id_usuari_free` INT(11) NOT NULL,
  INDEX `fk_USUARI_FREE_USUARI1_idx` (`id_usuari_free` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_FREE_USUARI1`
    FOREIGN KEY (`id_usuari_free`)
    REFERENCES `spotify`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`USUARI_PREMIUM` (
  `id_usuari_premium` INT(11) NOT NULL,
  PRIMARY KEY (`id_usuari_premium`),
  CONSTRAINT `fk_USUARI_PREMIUM_USUARI1`
    FOREIGN KEY (`id_usuari_premium`)
    REFERENCES `spotify`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`SUBSCRIPCIO` (
  `id_subscripcio` INT(11) NOT NULL AUTO_INCREMENT,
  `data_inici` DATE NOT NULL,
  `data_renovacio` DATE NOT NULL,
  `id_tipus` INT(11) NOT NULL,
  `id_usuari_premium` INT(11) NOT NULL,
  PRIMARY KEY (`id_subscripcio`),
  INDEX `fk_SUBSCRIPCIO_TIPUS_PAGAMENT1_idx` (`id_tipus` ASC) VISIBLE,
  INDEX `fk_SUBSCRIPCIO_USUARI_PREMIUM1_idx` (`id_usuari_premium` ASC) VISIBLE,
  CONSTRAINT `fk_SUBSCRIPCIO_TIPUS_PAGAMENT1`
    FOREIGN KEY (`id_tipus`)
    REFERENCES `spotify`.`TIPUS_PAGAMENT` (`id_tipus`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SUBSCRIPCIO_USUARI_PREMIUM1`
    FOREIGN KEY (`id_usuari_premium`)
    REFERENCES `spotify`.`USUARI_PREMIUM` (`id_usuari_premium`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`TIPUS_PAGAMENT` (
  `id_tipus` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_tipus`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`PAYPAL` (
  `nom_usuari` VARCHAR(45) NOT NULL,
  `id_tipus` INT(11) NOT NULL,
  PRIMARY KEY (`nom_usuari`),
  INDEX `fk_PAYPAL_TIPUS_PAGAMENT1_idx` (`id_tipus` ASC) VISIBLE,
  CONSTRAINT `fk_PAYPAL_TIPUS_PAGAMENT1`
    FOREIGN KEY (`id_tipus`)
    REFERENCES `spotify`.`TIPUS_PAGAMENT` (`id_tipus`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`TARGETA_CREDIT` (
  `numero_targeta` VARCHAR(20) NOT NULL,
  `mes_caducitat` INT(11) NOT NULL,
  `any_caducitat` INT(11) NOT NULL,
  `codi_seguretat` INT(11) NOT NULL,
  `id_tipus` INT(11) NOT NULL,
  PRIMARY KEY (`numero_targeta`),
  INDEX `fk_TARGETA_CREDIT_TIPUS_PAGAMENT1_idx` (`id_tipus` ASC) VISIBLE,
  CONSTRAINT `fk_TARGETA_CREDIT_TIPUS_PAGAMENT1`
    FOREIGN KEY (`id_tipus`)
    REFERENCES `spotify`.`TIPUS_PAGAMENT` (`id_tipus`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`PAGAMENT` (
  `id_pagament` INT(11) NOT NULL AUTO_INCREMENT,
  `data_pagament` DATE NOT NULL,
  `total` INT(11) NOT NULL,
  `id_subscripcio` INT(11) NOT NULL,
  PRIMARY KEY (`id_pagament`),
  INDEX `fk_PAGAMENT_SUBSCRIPCIO1_idx` (`id_subscripcio` ASC) VISIBLE,
  CONSTRAINT `fk_PAGAMENT_SUBSCRIPCIO1`
    FOREIGN KEY (`id_subscripcio`)
    REFERENCES `spotify`.`SUBSCRIPCIO` (`id_subscripcio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`ARTISTA` (
  `id_artista` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `imatge` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id_artista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`ALBUM` (
  `id_album` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(30) NOT NULL,
  `any_publicacio` DATE NOT NULL,
  `imatge` BLOB NULL DEFAULT NULL,
  `id_artista` INT(11) NOT NULL,
  PRIMARY KEY (`id_album`),
  INDEX `fk_ALBUM_ARTISTA1_idx` (`id_artista` ASC) VISIBLE,
  CONSTRAINT `fk_ALBUM_ARTISTA1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `spotify`.`ARTISTA` (`id_artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`CANÇO` (
  `id_canço` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(30) NOT NULL,
  `durada` INT(11) NOT NULL,
  `numero_reproduccions` INT(11) NOT NULL,
  `id_album` INT(11) NOT NULL,
  PRIMARY KEY (`id_canço`),
  INDEX `fk_CANÇO_ALBUM1_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `fk_CANÇO_ALBUM1`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`ALBUM` (`id_album`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`ARTISTA_SEGUIT` (
  `id_usuari` INT(11) NOT NULL,
  `id_artista` INT(11) NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_artista`),
  INDEX `fk_USUARI_has_ARTISTA_ARTISTA1_idx` (`id_artista` ASC) VISIBLE,
  INDEX `fk_USUARI_has_ARTISTA_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_has_ARTISTA_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USUARI_has_ARTISTA_ARTISTA1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `spotify`.`ARTISTA` (`id_artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`ARTISTA_RELACIONAT` (
  `id_artista_seguit` INT(11) NOT NULL,
  `id_artista_relacionat` INT(11) NOT NULL,
  PRIMARY KEY (`id_artista_seguit`, `id_artista_relacionat`),
  INDEX `fk_ARTISTA_has_ARTISTA_ARTISTA2_idx` (`id_artista_relacionat` ASC) VISIBLE,
  INDEX `fk_ARTISTA_has_ARTISTA_ARTISTA1_idx` (`id_artista_seguit` ASC) VISIBLE,
  CONSTRAINT `fk_ARTISTA_has_ARTISTA_ARTISTA1`
    FOREIGN KEY (`id_artista_seguit`)
    REFERENCES `spotify`.`ARTISTA` (`id_artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ARTISTA_has_ARTISTA_ARTISTA2`
    FOREIGN KEY (`id_artista_relacionat`)
    REFERENCES `spotify`.`ARTISTA` (`id_artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`CANÇO_FAVORITA` (
  `id_usuari` INT(11) NOT NULL,
  `id_canço` INT(11) NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_canço`),
  INDEX `fk_USUARI_has_CANÇO_CANÇO1_idx` (`id_canço` ASC) VISIBLE,
  INDEX `fk_USUARI_has_CANÇO_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_has_CANÇO_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USUARI_has_CANÇO_CANÇO1`
    FOREIGN KEY (`id_canço`)
    REFERENCES `spotify`.`CANÇO` (`id_canço`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`ALBUM_FAVORIT` (
  `id_usuari` INT(11) NOT NULL,
  `id_album` INT(11) NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_album`),
  INDEX `fk_USUARI_has_ALBUM_ALBUM1_idx` (`id_album` ASC) VISIBLE,
  INDEX `fk_USUARI_has_ALBUM_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_has_ALBUM_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USUARI_has_ALBUM_ALBUM1`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`ALBUM` (`id_album`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`PLAYLIST` (
  `id_playlist` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(30) NOT NULL,
  `numero_cançons` INT(11) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `id_usuari` INT(11) NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_PLAYLIST_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`CANÇO_PLAYLIST` (
  `id_playlist` INT(11) NOT NULL,
  `id_canço` INT(11) NOT NULL,
  PRIMARY KEY (`id_playlist`, `id_canço`),
  INDEX `fk_PLAYLIST_has_CANÇO_CANÇO1_idx` (`id_canço` ASC) VISIBLE,
  INDEX `fk_PLAYLIST_has_CANÇO_PLAYLIST1_idx` (`id_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_has_CANÇO_PLAYLIST1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`PLAYLIST` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PLAYLIST_has_CANÇO_CANÇO1`
    FOREIGN KEY (`id_canço`)
    REFERENCES `spotify`.`CANÇO` (`id_canço`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`PLAYLIST_ACTIVA` (
  `id_playlist` INT(11) NOT NULL,
  PRIMARY KEY (`id_playlist`),
  CONSTRAINT `fk_PLAYLIST_ACTIVA_PLAYLIST2`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`PLAYLIST` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`PLAYLIST_ESBORRADA` (
  `id_playlist` INT(11) NOT NULL,
  `data_eliminada` DATE NOT NULL,
  INDEX `fk_PLAYLIST_ESBORRADA_PLAYLIST1_idx` (`id_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_ESBORRADA_PLAYLIST1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`PLAYLIST` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`USUARIS_PLAYLIST` (
  `id_usuari` INT(11) NOT NULL,
  `id_playlist` INT(11) NOT NULL,
  `id_canço` INT(11) NOT NULL,
  `data_afegida` DATE NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_playlist`, `id_canço`),
  INDEX `fk_USUARI_has_PLAYLIST_ACTIVA_PLAYLIST_ACTIVA1_idx` (`id_playlist` ASC) VISIBLE,
  INDEX `fk_USUARI_has_PLAYLIST_ACTIVA_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  INDEX `fk_USUARIS_PLAYLIST_CANÇO1_idx` (`id_canço` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_has_PLAYLIST_ACTIVA_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USUARI_has_PLAYLIST_ACTIVA_PLAYLIST_ACTIVA1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`PLAYLIST_ACTIVA` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USUARIS_PLAYLIST_CANÇO1`
    FOREIGN KEY (`id_canço`)
    REFERENCES `spotify`.`CANÇO` (`id_canço`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
