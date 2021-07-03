-- MySQL Workbench Synchronization
-- Generated: 2021-07-03 16:34
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Pol Farreny Capdevila

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `youtube`.`USUARI` (
  `id_usuari` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `contrasenya` VARCHAR(20) NOT NULL,
  `nom_usuari` VARCHAR(20) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` VARCHAR(10) NULL DEFAULT NULL,
  `pais` VARCHAR(25) NOT NULL,
  `codi_postal` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_usuari`))
ENGINE = MRG_MyISAM
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`VIDEO` (
  `id_video` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(30) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `grandaria` INT(11) NOT NULL,
  `nom_arxiu` VARCHAR(45) NOT NULL,
  `durada` INT(11) NOT NULL,
  `thumbnail` VARCHAR(45) NOT NULL,
  `nombre_reproduccions` INT(11) NOT NULL,
  `id_estat_video` INT(11) NOT NULL,
  `id_usuari` INT(11) NOT NULL,
  `data_publicacio` DATETIME NOT NULL,
  `numero_likes` INT(11) NOT NULL,
  `numero_dislikes` INT(11) NOT NULL,
  PRIMARY KEY (`id_video`),
  INDEX `fk_VIDEO_ESTAT_VIDEO_idx` (`id_estat_video` ASC) VISIBLE,
  INDEX `fk_VIDEO_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_VIDEO_ESTAT_VIDEO`
    FOREIGN KEY (`id_estat_video`)
    REFERENCES `youtube`.`ESTAT_VIDEO` (`id_estat_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VIDEO_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`ESTAT_VIDEO` (
  `id_estat_video` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_estat_video`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`ETIQUETA` (
  `id_etiqueta` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_etiqueta` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_etiqueta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`DETALL_ETIQUETES` (
  `id_video` INT(11) NOT NULL,
  `id_etiqueta` INT(11) NOT NULL,
  PRIMARY KEY (`id_video`, `id_etiqueta`),
  INDEX `fk_VIDEO_has_ETIQUETA_ETIQUETA1_idx` (`id_etiqueta` ASC) VISIBLE,
  INDEX `fk_VIDEO_has_ETIQUETA_VIDEO1_idx` (`id_video` ASC) VISIBLE,
  CONSTRAINT `fk_VIDEO_has_ETIQUETA_VIDEO1`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`VIDEO` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VIDEO_has_ETIQUETA_ETIQUETA1`
    FOREIGN KEY (`id_etiqueta`)
    REFERENCES `youtube`.`ETIQUETA` (`id_etiqueta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`CANAL` (
  `id_canal` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_canal` VARCHAR(20) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `id_usuari` INT(11) NOT NULL,
  PRIMARY KEY (`id_canal`),
  INDEX `fk_CANAL_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_CANAL_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`SUBSCRIPCIO_CANAL` (
  `id_canal` INT(11) NOT NULL,
  `id_usuari` INT(11) NOT NULL,
  PRIMARY KEY (`id_canal`, `id_usuari`),
  INDEX `fk_CANAL_has_USUARI_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  INDEX `fk_CANAL_has_USUARI_CANAL1_idx` (`id_canal` ASC) VISIBLE,
  CONSTRAINT `fk_CANAL_has_USUARI_CANAL1`
    FOREIGN KEY (`id_canal`)
    REFERENCES `youtube`.`CANAL` (`id_canal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CANAL_has_USUARI_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`PLAYLIST` (
  `id_playlist` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_playlist` VARCHAR(25) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `id_usuari` INT(11) NOT NULL,
  `id_estat_playlist` INT(11) NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_PLAYLIST_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  INDEX `fk_PLAYLIST_ESTAT_PLAYLIST1_idx` (`id_estat_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PLAYLIST_ESTAT_PLAYLIST1`
    FOREIGN KEY (`id_estat_playlist`)
    REFERENCES `youtube`.`ESTAT_PLAYLIST` (`id_estat_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`ESTAT_PLAYLIST` (
  `id_estat_playlist` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_estat_playlist`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`COMENTARI` (
  `id_comentari` INT(11) NOT NULL AUTO_INCREMENT,
  `text_comentari` VARCHAR(500) NOT NULL,
  `data_comentari` DATETIME NOT NULL,
  `id_usuari` INT(11) NOT NULL,
  `id_video` INT(11) NOT NULL,
  PRIMARY KEY (`id_comentari`),
  INDEX `fk_COMENTARI_USUARI1_idx` (`id_usuari` ASC) VISIBLE,
  INDEX `fk_COMENTARI_VIDEO1_idx` (`id_video` ASC) VISIBLE,
  CONSTRAINT `fk_COMENTARI_USUARI1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`USUARI` (`id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_COMENTARI_VIDEO1`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`VIDEO` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`LIKES_VIDEO` (
  `id_usuari` INT(11) NOT NULL,
  `id_video` INT(11) NOT NULL,
  `data_like` DATETIME NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_video`),
  INDEX `fk_USUARI_has_VIDEO_VIDEO1_idx` (`id_video` ASC) VISIBLE,
  INDEX `fk_USUARI_has_VIDEO_USUARI1_idx` (`id_usuari` ASC) VISIBLE)
ENGINE = MRG_MyISAM
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`DISLIKES_VIDEO` (
  `id_usuari` INT(11) NOT NULL,
  `id_video` INT(11) NOT NULL,
  `data_dislike` DATETIME NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_video`),
  INDEX `fk_USUARI_has_VIDEO_VIDEO2_idx` (`id_video` ASC) VISIBLE,
  INDEX `fk_USUARI_has_VIDEO_USUARI2_idx` (`id_usuari` ASC) VISIBLE)
ENGINE = MRG_MyISAM
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`LIKES_COMENTARI` (
  `id_usuari` INT(11) NOT NULL,
  `id_comentari` INT(11) NOT NULL,
  `data_like` DATETIME NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_comentari`),
  INDEX `fk_USUARI_has_COMENTARI_COMENTARI1_idx` (`id_comentari` ASC) VISIBLE,
  INDEX `fk_USUARI_has_COMENTARI_USUARI1_idx` (`id_usuari` ASC) VISIBLE)
ENGINE = MRG_MyISAM
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`DISLIKES_COMENTARI` (
  `id_usuari` INT(11) NOT NULL,
  `id_comentari` INT(11) NOT NULL,
  `data_dislike` DATETIME NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_comentari`),
  INDEX `fk_USUARI_has_COMENTARI_COMENTARI2_idx` (`id_comentari` ASC) VISIBLE,
  INDEX `fk_USUARI_has_COMENTARI_USUARI2_idx` (`id_usuari` ASC) VISIBLE)
ENGINE = MRG_MyISAM
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
