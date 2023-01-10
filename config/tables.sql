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

CREATE TABLE brewing_method (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(20)
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

CREATE TABLE seller_tea (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    tea_id INTEGER UNSIGNED DEFAULT NULL,
    seller_id INTEGER UNSIGNED DEFAULT NULL,
    origin VARCHAR(30),
    harvest_year VARCHAR(20),
    packaging_id INTEGER UNSIGNED DEFAULT NULL,
    CONSTRAINT fk_st_t FOREIGN KEY (tea_id) REFERENCES tea (id),
    CONSTRAINT fk_st_s FOREIGN KEY (seller_id) REFERENCES seller (id),
    CONSTRAINT fk_st_s FOREIGN KEY (packaging_id) REFERENCES packaging (id)
);

CREATE TABLE order_item (
    order_id INTEGER UNSIGNED DEFAULT NULL,
    seller_tea_id INTEGER UNSIGNED DEFAULT NULL,
    price DECIMAL(19, 4) DEFAULT 0.0,
    amount_in_grams INTEGER UNSIGNED DEFAULT 0,
    CONSTRAINT pk_oi PRIMARY KEY (order_id, seller_tea_id),
    CONSTRAINT fk_oi_o FOREIGN KEY (order_id) REFERENCES order (id),
    CONSTRAINT fk_oi_t FOREIGN KEY (seller_tea_id) REFERENCES seller_tea (id)
);

CREATE TABLE session (
    id INTEGER UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    seller_tea_id INTEGER UNSIGNED DEFAULT NULL,
    `timestamp` TIMESTAMP DEFAULT NOW(),
    brewing_method_id INTEGER UNSIGNED DEFAULT NULL,
    nr_of_steepings TINYINT UNSIGNED,
    nr_of_participants TINYINT UNSIGNED,
    notes VARCHAR(1000),
    CONSTRAINT fk_s_st FOREIGN KEY (seller_tea_id) REFERENCES seller_tea (id),
    CONSTRAINT fk_s_bm FOREIGN KEY (brewing_method_id) REFERENCES brewing_method (id)
);

/* insertions */
INSERT INTO `type` (`name`)
VALUES
    ('green'), ('black'), ('oolong'), ('white'),
    ('pu-erh'), ('yellow'), ('scented'), ('herbal');

INSERT INTO packaging (`name`)
VALUES
    ('bagged'), ('loose'), ('compressed');

INSERT INTO brewing_method (`name`)
VALUES
    ('gong fu cha'), ('western'), ('grandpa'),
    ('cup'), ('cold brew');
