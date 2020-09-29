SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`node_infos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`node_infos` (
  `node_info_id` VARCHAR(45) NOT NULL ,
  `memory_mb` INT(11) NULL ,
  `memory_mb_free` INT(11) NULL ,
  `numa_topology` TEXT NULL ,
  `metrics` TEXT NULL ,
  `processor_core` INT NULL ,
  `processor_count` INT NULL ,
  `processor_threads_per_core` INT NULL ,
  `processor_vcpu` INT NULL ,
  `node_name` VARCHAR(45) NULL ,
  `os_family` VARCHAR(45) NULL ,
  `pkg_mgr` VARCHAR(45) NULL ,
  `os_version` VARCHAR(45) NULL ,
  `default_ipv4` VARCHAR(45) NULL ,
  `default_broadcast` VARCHAR(45) NULL ,
  `default_gateway` VARCHAR(45) NULL ,
  `default_interface_id` VARCHAR(45) NULL ,
  PRIMARY KEY (`node_info_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`deployments`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`deployments` (
  `deployment_id` INT(11) NOT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  `finished_at` DATETIME NULL ,
  `status` VARCHAR(45) NULL ,
  `name` VARCHAR(45) NULL ,
  `jsondata` TEXT NULL ,
  `log` TEXT NULL ,
  `result` VARCHAR(45) NULL ,
  `progress` VARCHAR(45) NULL ,
  PRIMARY KEY (`deployment_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`nodes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`nodes` (
  `node_id` INT(11) NOT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  `deleted_at` DATETIME NULL ,
  `management_id` VARCHAR(45) NULL ,
  `ssh_user` VARCHAR(45) NULL ,
  `ssh_password` VARCHAR(45) NULL ,
  `status` TEXT NULL ,
  `node_display_name` VARCHAR(45) NULL ,
  `node_info_id` VARCHAR(45) NULL ,
  `deployment_id` INT(11) NULL ,
  `role_type` VARCHAR(45) NULL ,
  PRIMARY KEY (`node_id`) ,
  CONSTRAINT `fk_nodes_hardware_infos1`
    FOREIGN KEY (`node_info_id` )
    REFERENCES `mydb`.`node_infos` (`node_info_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nodes_deployments1`
    FOREIGN KEY (`deployment_id` )
    REFERENCES `mydb`.`deployments` (`deployment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_nodes_hardware_infos1_idx` ON `mydb`.`nodes` (`node_info_id` ASC) ;

CREATE INDEX `fk_nodes_deployments1_idx` ON `mydb`.`nodes` (`deployment_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`service_setups`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`service_setups` (
  `service_setup_id` VARCHAR(45) NOT NULL ,
  `service_type` VARCHAR(45) NULL ,
  `service_name` VARCHAR(45) NULL ,
  `service_info` TEXT NULL ,
  `service_lib` TEXT NULL ,
  `service_config_folder` TEXT NULL ,
  PRIMARY KEY (`service_setup_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`deployment_service`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`deployment_service` (
  `id` INT(11) NOT NULL ,
  `setup_index` INT NULL ,
  `is_validated_success` VARCHAR(45) NULL ,
  `validated_status` VARCHAR(45) NULL ,
  `deployment_id` INT(11) NOT NULL ,
  `service_setup_id` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_deployment_service_deployments1`
    FOREIGN KEY (`deployment_id` )
    REFERENCES `mydb`.`deployments` (`deployment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deployment_service_services1`
    FOREIGN KEY (`service_setup_id` )
    REFERENCES `mydb`.`service_setups` (`service_setup_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_deployment_service_deployments1_idx` ON `mydb`.`deployment_service` (`deployment_id` ASC) ;

CREATE INDEX `fk_deployment_service_services1_idx` ON `mydb`.`deployment_service` (`service_setup_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`interface_resources`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`interface_resources` (
  `interface_id` VARCHAR(45) NOT NULL ,
  `device_name` VARCHAR(45) NULL ,
  `speed` INT(11) NULL ,
  `port_info` TEXT NULL ,
  `active` VARCHAR(45) NULL ,
  `features` TEXT NULL ,
  `macaddress` VARCHAR(45) NULL ,
  `module` VARCHAR(45) NULL ,
  `mtu` INT NULL ,
  `pciid` VARCHAR(45) NULL ,
  `phc_index` INT NULL ,
  `speed` INT NULL ,
  `type` VARCHAR(45) NULL ,
  `is_default_ip` VARCHAR(45) NULL ,
  `node_info_id` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`interface_id`) ,
  CONSTRAINT `fk_interface_resources_node_infos1`
    FOREIGN KEY (`node_info_id` )
    REFERENCES `mydb`.`node_infos` (`node_info_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_interface_resources_node_infos1_idx` ON `mydb`.`interface_resources` (`node_info_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`tasks`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tasks` (
  `task_id` INT(11) NOT NULL ,
  `created_at` DATETIME NULL ,
  `finished_at` DATETIME NULL ,
  `task_display_name` VARCHAR(45) NULL ,
  `setup_data` VARCHAR(45) NULL ,
  `task_type` VARCHAR(45) NULL ,
  `status` VARCHAR(45) NULL ,
  `result` VARCHAR(45) NULL ,
  `log` TEXT NULL ,
  PRIMARY KEY (`task_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`setup_task`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`setup_task` (
  `id` INT(11) NOT NULL ,
  `service_name` VARCHAR(45) NULL ,
  `task_index` VARCHAR(45) NULL ,
  `service_setup_id` VARCHAR(45) NOT NULL ,
  `task_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `task_id`) ,
  CONSTRAINT `fk_service_task_services1`
    FOREIGN KEY (`service_setup_id` )
    REFERENCES `mydb`.`service_setups` (`service_setup_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_task_tasks1`
    FOREIGN KEY (`task_id` )
    REFERENCES `mydb`.`tasks` (`task_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_service_task_services1_idx` ON `mydb`.`setup_task` (`service_setup_id` ASC) ;

CREATE INDEX `fk_service_task_tasks1_idx` ON `mydb`.`setup_task` (`task_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`file_config`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`file_config` (
  `file_id` INT(11) NOT NULL ,
  `node_id` INT(11) NOT NULL ,
  `file_name` VARCHAR(45) NULL ,
  `file_path` VARCHAR(45) NULL ,
  `service_name` VARCHAR(45) NULL ,
  `created_at` DATETIME NULL ,
  `modified_at` DATETIME NULL ,
  PRIMARY KEY (`file_id`) ,
  CONSTRAINT `fk_file_config_nodes1`
    FOREIGN KEY (`node_id` )
    REFERENCES `mydb`.`nodes` (`node_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_file_config_nodes1_idx` ON `mydb`.`file_config` (`node_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`changes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`changes` (
  `change_id` VARCHAR(45) NOT NULL ,
  `created_at` DATETIME NULL ,
  `finished_at` DATETIME NULL ,
  `status` VARCHAR(45) NULL ,
  `change_type` VARCHAR(45) NULL ,
  `new_service` VARCHAR(45) NULL ,
  `backup_service` VARCHAR(45) NULL ,
  `new_file` TEXT NULL ,
  `backup_file` TEXT NULL ,
  `new_folder` TEXT NULL ,
  `backup_folder` TEXT NULL ,
  `change_log` TEXT NULL ,
  `task_id` INT(11) NULL ,
  `change_index` INT NULL ,
  `file_config_id` VARCHAR(45) NULL ,
  `file_config_file_id` INT(11) NOT NULL ,
  PRIMARY KEY (`change_id`) ,
  CONSTRAINT `fk_changes_tasks1`
    FOREIGN KEY (`task_id` )
    REFERENCES `mydb`.`tasks` (`task_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_changes_file_config1`
    FOREIGN KEY (`file_config_file_id` )
    REFERENCES `mydb`.`file_config` (`file_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_changes_tasks1_idx` ON `mydb`.`changes` (`task_id` ASC) ;

CREATE INDEX `fk_changes_file_config1_idx` ON `mydb`.`changes` (`file_config_file_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`update`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`update` (
  `update_id` VARCHAR(45) NOT NULL ,
  `created_at` DATETIME NULL ,
  `deleted_at` DATETIME NULL ,
  `note` TEXT NULL ,
  `log` TEXT NULL ,
  PRIMARY KEY (`update_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`update_change`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`update_change` (
  `id` INT(11) NOT NULL ,
  `update_id` VARCHAR(45) NOT NULL ,
  `change_id` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_update_change_update1`
    FOREIGN KEY (`update_id` )
    REFERENCES `mydb`.`update` (`update_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_update_change_changes1`
    FOREIGN KEY (`change_id` )
    REFERENCES `mydb`.`changes` (`change_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_update_change_update1_idx` ON `mydb`.`update_change` (`update_id` ASC) ;

CREATE INDEX `fk_update_change_changes1_idx` ON `mydb`.`update_change` (`change_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`password`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`password` (
  `password_id` INT(11) NOT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  `user` VARCHAR(45) NULL ,
  `password` VARCHAR(45) NULL ,
  `update_id` VARCHAR(45) NOT NULL ,
  `service_name` VARCHAR(45) NULL ,
  PRIMARY KEY (`password_id`, `update_id`) ,
  CONSTRAINT `fk_password_update1`
    FOREIGN KEY (`update_id` )
    REFERENCES `mydb`.`update` (`update_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_password_update1_idx` ON `mydb`.`password` (`update_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`openstack_config`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`openstack_config` (
  `config_id` VARCHAR(45) NOT NULL ,
  `created_at` DATETIME NULL ,
  `deleted_at` DATETIME NULL ,
  `key` VARCHAR(45) NULL ,
  `value` TEXT NULL ,
  `service` VARCHAR(45) NULL ,
  `update_id` VARCHAR(45) NOT NULL ,
  `password_id` INT(11) NULL ,
  `block` VARCHAR(45) NULL ,
  `file_id` INT(11) NOT NULL ,
  `activate` INT NULL ,
  PRIMARY KEY (`config_id`, `update_id`, `file_id`) ,
  CONSTRAINT `fk_openstack_config_update1`
    FOREIGN KEY (`update_id` )
    REFERENCES `mydb`.`update` (`update_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_openstack_config_password1`
    FOREIGN KEY (`password_id` )
    REFERENCES `mydb`.`password` (`password_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_openstack_config_file_config1`
    FOREIGN KEY (`file_id` )
    REFERENCES `mydb`.`file_config` (`file_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_openstack_config_update1_idx` ON `mydb`.`openstack_config` (`update_id` ASC) ;

CREATE INDEX `fk_openstack_config_password1_idx` ON `mydb`.`openstack_config` (`password_id` ASC) ;

CREATE INDEX `fk_openstack_config_file_config1_idx` ON `mydb`.`openstack_config` (`file_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`disk_resources`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`disk_resources` (
  `disk_id` VARCHAR(45) NOT NULL ,
  `device_name` VARCHAR(45) NULL ,
  `size` INT NULL ,
  `model` VARCHAR(45) NULL ,
  `removable` INT NULL ,
  `sectors` MEDIUMTEXT NULL ,
  `sectorsize` INT NULL ,
  `serial` VARCHAR(45) NULL ,
  `vendor` VARCHAR(45) NULL ,
  `support_discard` VARCHAR(45) NULL ,
  `virtual` INT NULL ,
  `node_info_id` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`disk_id`) ,
  CONSTRAINT `fk_disk_resources_node_infos1`
    FOREIGN KEY (`node_info_id` )
    REFERENCES `mydb`.`node_infos` (`node_info_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_disk_resources_node_infos1_idx` ON `mydb`.`disk_resources` (`node_info_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`service_infos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`service_infos` (
  `service_id` INT(11) NOT NULL ,
  `service_type` VARCHAR(45) NULL ,
  `service_status` VARCHAR(45) NULL ,
  `tag` VARCHAR(45) NULL ,
  `node_id` INT(11) NOT NULL ,
  PRIMARY KEY (`service_id`) ,
  CONSTRAINT `fk_service_infos_nodes1`
    FOREIGN KEY (`node_id` )
    REFERENCES `mydb`.`nodes` (`node_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_service_infos_nodes1_idx` ON `mydb`.`service_infos` (`node_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`service_info_file_config`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`service_info_file_config` (
  `id` INT(11) NOT NULL ,
  `service_id` INT(11) NOT NULL ,
  `file_config_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_service_info_file_config_service_infos1`
    FOREIGN KEY (`service_id` )
    REFERENCES `mydb`.`service_infos` (`service_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_info_file_config_file_config1`
    FOREIGN KEY (`file_config_id` )
    REFERENCES `mydb`.`file_config` (`file_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_service_info_file_config_service_infos1_idx` ON `mydb`.`service_info_file_config` (`service_id` ASC) ;

CREATE INDEX `fk_service_info_file_config_file_config1_idx` ON `mydb`.`service_info_file_config` (`file_config_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`node_roles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`node_roles` (
  `id` INT(11) NOT NULL ,
  `role_name` VARCHAR(45) NULL ,
  `node_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_node_roles_nodes1`
    FOREIGN KEY (`node_id` )
    REFERENCES `mydb`.`nodes` (`node_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_node_roles_nodes1_idx` ON `mydb`.`node_roles` (`node_id` ASC) ;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
