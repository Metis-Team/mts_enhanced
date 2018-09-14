CREATE DATABASE IF NOT EXISTS `armory` ;
USE `armory`;

CREATE TABLE IF NOT EXISTS `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `editors` text NOT NULL,
  `arsenal` varchar(5) NOT NULL DEFAULT 'false',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `backpack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `idc` int(11) NOT NULL,
  `class` varchar(100) NOT NULL,
  `items` text NOT NULL,
  `equipment` int(11) NOT NULL,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_equipment` (`name`,`equipment`),
  KEY `equipment` (`equipment`),
  CONSTRAINT `backpack_ibfk_1` FOREIGN KEY (`equipment`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `loadout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `idc` int(11) NOT NULL,
  `loadout` text NOT NULL,
  `ace_medic` tinyint(2) NOT NULL,
  `ace_engineer` tinyint(2) NOT NULL,
  `equipment` int(11) NOT NULL,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_equipment` (`name`,`equipment`),
  KEY `equipment` (`equipment`),
  CONSTRAINT `loadout_ibfk_1` FOREIGN KEY (`equipment`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

