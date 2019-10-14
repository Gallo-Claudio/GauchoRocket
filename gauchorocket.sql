insert into usuarios value(1,"gallo","1234");

select * from usuarios;

select * from roles;

create database gauchorocket;
use gauchorocket;

CREATE TABLE roles (
id INT AUTO_INCREMENT,
rol VARCHAR(30),
PRIMARY KEY (id)
);

CREATE TABLE usuarios (
id INT AUTO_INCREMENT,
usuario VARCHAR(30) NOT NULL,
clave VARCHAR(15) NOT NULL,
rol INT,
PRIMARY KEY (id),
FOREIGN KEY (rol) REFERENCES roles(id)
);

insert into roles value
(1,"Administrador"),
(2,"Usuario");

insert into usuarios value
(1,"Tomas","1234","1"),
(2,"Sebastian","1234","2"),
(3,"Julieta","1234","2");