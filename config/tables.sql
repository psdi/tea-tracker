CREATE DATABASE tea_tracker;
/* create user with privileges */
USE tea_tracker;

CREATE TABLE `type` (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(10)
);

CREATE TABLE packaging (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(10)
);

CREATE TABLE tea (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    type_id INTEGER UNSIGNED DEFAULT NULL,
    `name` VARCHAR(50),
    remarks VARCHAR(1000)
);

CREATE TABLE seller (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(75),
    `location` VARCHAR(50)
);

CREATE TABLE order (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `date` DATETIME DEFAULT NOW(),
    seller_id INTEGER UNSIGNED DEFAULT NULL,
    shipping_fees DECIMAL(19, 4) DEFAULT 0.0,
    CONSTRAINT fk_o_s FOREIGN KEY (seller_id) REFERENCES seller (id)
);

CREATE TABLE order_item (
    order_id INTEGER UNSIGNED DEFAULT NULL,
    tea_id INTEGER UNSIGNED DEFAULT NULL,
    price DECIMAL(19, 4) DEFAULT 0.0,
    amount_in_grams INTEGER UNSIGNED DEFAULT 0,
    CONSTRAINT pk_oi PRIMARY KEY (order_id, tea_id),
    CONSTRAINT fk_oi_o FOREIGN KEY (order_id) REFERENCES order (id),
    CONSTRAINT fk_oi_t FOREIGN KEY (tea_id) REFERENCES tea (id)
);

CREATE TABLE sessions (
    /* todo */
);

CREATE TABLE tea_seller (
    /* todo */
);

/* insertions */
INSERT INTO `type` (`name`)
VALUES
    ('green'), ('black'), ('oolong'), ('white'),
    ('pu-erh'), ('yellow'), ('scented'), ('herbal');

INSERT INTO `packaging` (`name`)
VALUES
    ('bagged'), ('loose'), ('compressed');
