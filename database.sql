CREATE DATABASE julia_rest;

USE julia_rest;

CREATE TABLE posts (
id INT NOT NULL AUTO_INCREMENT,
titre VARCHAR(100) NOT NULL,
description VARCHAR(255) NOT NULL,
date_publication datetime NOT NULL,
PRIMARY KEY(id));
