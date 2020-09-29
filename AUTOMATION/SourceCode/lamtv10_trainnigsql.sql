SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `lamtv10` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `lamtv10` ;

-- -----------------------------------------------------
-- Table `lamtv10`.`movies`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lamtv10`.`movies` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(255) NULL ,
  `release_date` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lamtv10`.`actors`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lamtv10`.`actors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `birthday` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lamtv10`.`contacts`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lamtv10`.`contacts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `phone_number` VARCHAR(255) NULL ,
  `address` VARCHAR(255) NULL ,
  `actors_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_contacts_actors1`
    FOREIGN KEY (`actors_id` )
    REFERENCES `lamtv10`.`actors` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_contacts_actors1_idx` ON `lamtv10`.`contacts` (`actors_id` ASC) ;


-- -----------------------------------------------------
-- Table `lamtv10`.`stuntman`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lamtv10`.`stuntman` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `active` INT NULL ,
  `actors_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `actors_id`) ,
  CONSTRAINT `fk_stuntman_actors1`
    FOREIGN KEY (`actors_id` )
    REFERENCES `lamtv10`.`actors` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_stuntman_actors1_idx` ON `lamtv10`.`stuntman` (`actors_id` ASC) ;


-- -----------------------------------------------------
-- Table `lamtv10`.`movie_actor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lamtv10`.`movie_actor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `movies_id` INT(11) NOT NULL ,
  `actors_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `movies_id`) ,
  CONSTRAINT `fk_movie_actor_movies`
    FOREIGN KEY (`movies_id` )
    REFERENCES `lamtv10`.`movies` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_actor_actors1`
    FOREIGN KEY (`actors_id` )
    REFERENCES `lamtv10`.`actors` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_movie_actor_movies_idx` ON `lamtv10`.`movie_actor` (`movies_id` ASC) ;

CREATE INDEX `fk_movie_actor_actors1_idx` ON `lamtv10`.`movie_actor` (`actors_id` ASC) ;

USE `lamtv10` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
