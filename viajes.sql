create table dias (
id int auto_increment,
dia varchar(9),
primary key (id)
);

insert into dias values
(1, "Lunes"),
(2, "Martes"),
(3, "Miercoles"),
(4, "Jueves"),
(5, "Viernes"),
(6, "Sabados"),
(7, "Domingos");

create table horas (
id int auto_increment,
hora varchar(5),
primary key (id)
);

insert into horas values
(1, "7:00"),
(2, "11:00"),
(3, "13:00"),
(4, "15:00"),
(5, "19:00"),
(6, "23:00");

create table tipo_viajes (
id int auto_increment,
tipo_viaje varchar(25),
primary key (id)
);

insert into tipo_viajes values
(1, "Tour"),
(2, "Suborbitales"),
(3, "Entre destinos");

create table viajes (
id int auto_increment,
dia int,
hora int,
tipo_viaje int,
duracion varchar(10),
primary key (id),
foreign key (dia) references dias(id),
foreign key (hora) references horas(id),
foreign key (tipo_viaje) references tipo_viajes(id)
);

insert into viajes values
/*tour*/
(1, 7, 3, 1, "35 dias"),
/*suborbitales*/
/* 7:00 */
(2, 1, 1, 2, "8 horas"),
(3, 2, 1, 2, "8 horas"),
(4, 3, 1, 2, "8 horas"),
(5, 4, 1, 2, "8 horas"),
(6, 5, 1, 2, "8 horas"),
(7, 6, 1, 2, "8 horas"),
(8, 7, 1, 2, "8 horas"),
/* 11:00 */
(9, 1, 2, 2, "8 horas"),
(10, 2, 2, 2, "8 horas"),
(11, 3, 2, 2, "8 horas"),
(12, 4, 2, 2, "8 horas"),
(13, 5, 2, 2, "8 horas"),
(14, 6, 2, 2, "8 horas"),
(15, 7, 2, 2, "8 horas"),
/* 15:00 */
(16, 1, 4, 2, "8 horas"),
(17, 2, 4, 2, "8 horas"),
(18, 3, 4, 2, "8 horas"),
(19, 4, 4, 2, "8 horas"),
(20, 5, 4, 2, "8 horas"),
(21, 6, 4, 2, "8 horas"),
(22, 7, 4, 2, "8 horas"),
/* 19:00 */
(23, 1, 5, 2, "8 horas"),
(24, 2, 5, 2, "8 horas"),
(25, 3, 5, 2, "8 horas"),
(26, 4, 5, 2, "8 horas"),
(27, 5, 5, 2, "8 horas"),
(28, 6, 5, 2, "8 horas"),
(29, 7, 5, 2, "8 horas"),
/* 23:00 */
(30, 1, 6, 2, "8 horas"),
(31, 2, 6, 2, "8 horas"),
(32, 3, 6, 2, "8 horas"),
(33, 4, 6, 2, "8 horas"),
(34, 5, 6, 2, "8 horas"),
(35, 6, 6, 2, "8 horas"),
(36, 7, 6, 2, "8 horas"),
/*entre destinos*/
/* 7:00 */
(37, 1, 1, 3, null),
(38, 2, 1, 3, null),
(39, 3, 1, 3, null),
(40, 4, 1, 3, null),
(41, 5, 1, 3, null),
(42, 6, 1, 3, null),
(43, 7, 1, 3, null),
/* 15:00 */
(44, 1, 4, 3, null),
(45, 2, 4, 3, null),
(46, 3, 4, 3, null),
(47, 4, 4, 3, null),
(48, 5, 4, 3, null),
(49, 6, 4, 3, null),
(50, 7, 4, 3, null),
/* 23:00 */
(51, 1, 6, 3, null),
(52, 2, 6, 3, null),
(53, 3, 6, 3, null),
(54, 4, 6, 3, null),
(55, 5, 6, 3, null),
(56, 6, 6, 3, null),
(57, 7, 6, 3, null);