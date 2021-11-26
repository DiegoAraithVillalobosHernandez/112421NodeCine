CREATE DATABASE cinema;
USE cinema;

CREATE TABLE categorys(
	id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(20) NOT NULL
);

CREATE TABLE movies(
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title varchar(255) NOT NULL,
    description text,
    synopsis text,
    rating int NOT NULL CHECK (rating>0 and rating<11),
    register_date datetime NOT NULL,
    updated_date datetime NOT NULL,
    state tinyint NOT NULL CHECK (state in(1,0)),
    category int NOT NULL,
    FOREIGN KEY(category) REFERENCES categorys(id)
);