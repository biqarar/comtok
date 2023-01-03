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
	`id`           int UNSIGNED                                   NOT NULL AUTO_INCREMENT,
	`user_id`      int UNSIGNED                                   NOT NULL,
	`seller_id`    int UNSIGNED                                   NOT NULL,
	`product_id`   int UNSIGNED                                   NOT NULL,
	`count`        decimal(13, 4)                                 NULL,
	`total`        decimal(13, 4)                                 NULL,
	`status`       enum ('draft', 'enable', 'disable', 'deleted') NOT NULL DEFAULT 'draft',
	`datecreated`  timestamp                                      NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`datemodified` timestamp                                      NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `orders_for_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `orders_for_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `orders_for_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;



CREATE TABLE IF NOT EXISTS `commissionTransactions`
(
	`id`            int UNSIGNED                         NOT NULL AUTO_INCREMENT,
	`seller_id`     int UNSIGNED                         NOT NULL,
	`order_id`      int UNSIGNED                         NOT NULL,
	`commission_id` int UNSIGNED                         NOT NULL,
	`amount`        decimal(13, 4)                       NULL,
	`datepayable`   date                                 NULL,
	`datepayed`     date                                 NULL,
	`status`        enum ('active', 'deactive')          NOT NULL DEFAULT 'active',
	`paystatus`     enum ('awaiting', 'payed', 'refund') NOT NULL DEFAULT 'awaiting',
	`datecreated`   timestamp                            NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`datemodified`  timestamp                            NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `commissionTransactions_for_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `commissions` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `commissionTransactions_for_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `commissionTransactions_for_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `bankLogs`
(
	`id`           int UNSIGNED                                          NOT NULL AUTO_INCREMENT,
	`bank`         varchar(200)                                          NOT NULL,
	`token`        varchar(255)                                          NOT NULL,
	`amount`       decimal(13, 4)                                        NULL,
	`date`         datetime                                              NULL,
	`verify`       bit                                                   NULL,
	`status`       enum ('pending', 'payed', 'cancel', 'error', 'other') NOT NULL DEFAULT 'pending',
	`datecreated`  timestamp                                             NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`datemodified` timestamp                                             NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;



CREATE TABLE IF NOT EXISTS `transactions`
(
	`id`           int UNSIGNED                NOT NULL AUTO_INCREMENT,
	`user_id`      int UNSIGNED                NOT NULL,
	`plus`         decimal(13, 4)              NULL,
	`minus`        decimal(13, 4)              NULL,
	`date`         datetime                    NULL,
	`bankLog_id`   int UNSIGNED                NULL,
	`status`       enum ('active', 'deactive') NOT NULL DEFAULT 'active',
	`datecreated`  timestamp                   NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`datemodified` timestamp                   NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `transactions_for_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `transactions_for_bank_id` FOREIGN KEY (`bankLog_id`) REFERENCES `bankLogs` (`id`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
