CREATE DATABASE IF NOT EXISTS `comtok` CHAR SET utf8mb4;

USE `comtok`;

CREATE TABLE IF NOT EXISTS `users`
(
	`id`          int UNSIGNED NOT NULL AUTO_INCREMENT,
	`name`        varchar(255) NOT NULL,
	`email`       varchar(255) NOT NULL,
	`password`    varchar(255) NOT NULL,
	`datecreated` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `index_users_search_email` (`email`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;



CREATE TABLE IF NOT EXISTS `products`
(
	`id`          int UNSIGNED   NOT NULL AUTO_INCREMENT,
	`user_id`     int UNSIGNED   NOT NULL,
	`title`       varchar(255)   NOT NULL,
	`price`       decimal(13, 4) NULL,
	`datecreated` timestamp      NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `product_for_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
	INDEX `index_search_title` (`title`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS `commissions`
(
	`id`           int UNSIGNED                NOT NULL AUTO_INCREMENT,
	`user_id`      int UNSIGNED                NOT NULL,
	`value`        decimal(13, 4)              NULL,
	`status`       enum ('active', 'deactive') NOT NULL DEFAULT 'active',
	`datecreated`  timestamp                   NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`datemodified` timestamp                   NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `commissions_for_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `orders`
(
	`id`           int UNSIGNED                NOT NULL AUTO_INCREMENT,
	`user_id`      int UNSIGNED                NOT NULL,
	`product_id`   int UNSIGNED                NOT NULL,
	`seller_id`    int UNSIGNED                NOT NULL,
	`count`        decimal(13, 4)              NULL,
	`total`        decimal(13, 4)              NULL,
	`status`       enum ('active', 'deactive') NOT NULL DEFAULT 'active',
	`datecreated`  timestamp                   NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`datemodified` timestamp                   NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `commissions_for_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

