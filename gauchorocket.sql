
--
-- Base de datos: `gauchorocket`
--
CREATE DATABASE gauchorocket;
USE gauchorocket;

-- --------------------------------------------------------

--
-- NUEVO PARA TARJETA DE CREDITO
--
ALTER TABLE `reservas` ADD `pago` boolean;

create table `meses` (`meses` varchar (25) NOT NULL);

alter table meses add id int(11) NOT NULL primary key;

insert INTO meses (id,meses) values (1,'Enero'),
                                    (2,'Febrero'),
                                    (3,'Marzo'),
                                    (4,'Abril'),
                                    (5,'Mayo'),
                                    (6,'Junio'),
                                    (7,'Julio'),
                                    (8,'Agosto'),
                                    (9,'Septiembre'),
                                    (10,'Octubre'),
                                    (11,'Noviembre'),
                                    (12,'Diciembre');


create table anio (id int (11) primary key auto_increment,
                   anio int(4));

insert into anio (id,anio) values   (1,2019),
                                    (2,2020),
                                    (3,2021),
                                    (4,2022),
                                    (5,2023),
                                    (6,2024),
                                    (7,2025);

alter table usuarios add cod_seguridad int (3);
--
-- Estructura de tabla para la tabla `circuitos`
--

CREATE TABLE `circuitos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `circuitos`
--

INSERT INTO `circuitos` (`id`, `nombre`) VALUES
(1, 'Circuito 1'),
(2, 'Circuito 2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `circuitos_estaciones`
--

CREATE TABLE `circuitos_estaciones` (
  `circuito_id` int(11) NOT NULL,
  `estacion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `circuitos_estaciones`
--

INSERT INTO `circuitos_estaciones` (`circuito_id`, `estacion_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 2),
(2, 3),
(2, 5),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credenciales`
--

CREATE TABLE `credenciales` (
  `id` int(11) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `rol` int(11) DEFAULT NULL,
  `clave` varchar(50) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `credenciales`
--

INSERT INTO `credenciales` (`id`, `usuario`, `rol`, `clave`, `id_usuario`) VALUES
(1, 'Tomas', 1, '81dc9bdb52d04dc20036dbd8313ed055', 1),
(2, 'Sebastian', 2, '81dc9bdb52d04dc20036dbd8313ed055', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estaciones`
--

CREATE TABLE `estaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estaciones`
--

INSERT INTO `estaciones` (`id`, `nombre`) VALUES
(1, 'Buenos Aires'),
(2, 'Ankara'),
(3, 'EEI'),
(4, 'Orbital Hotel'),
(5, 'Luna'),
(6, 'Marte'),
(7, 'Ganimedes'),
(8, 'Europa'),
(9, 'Io'),
(10, 'Encedalo'),
(11, 'Titan');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelos_naves`
--

CREATE TABLE `modelos_naves` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `modelos_naves`
--

INSERT INTO `modelos_naves` (`id`, `nombre`, `capacidad`) VALUES
(1, 'Calandria', 300),
(2, 'Colibrí', 120),
(3, 'Zorzal', 100),
(4, 'Carancho', 110),
(5, 'Aguilucho', 60),
(6, 'Canario', 80),
(7, 'Águila', 300),
(8, 'Condor', 350),
(9, 'Halcón', 200),
(10, 'Guanaco', 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `naves`
--

CREATE TABLE `naves` (
  `id` int(11) NOT NULL,
  `matricula` varchar(8) DEFAULT NULL,
  `modelo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `naves`
--

INSERT INTO `naves` (`id`, `matricula`, `modelo`) VALUES
(1, 'O1', 1),
(2, 'O2', 1),
(3, 'O3', 2),
(4, 'O4', 2),
(5, 'O5', 2),
(6, 'O6', 1),
(7, 'O7', 1),
(8, 'O8', 2),
(9, 'O9', 2),
(10, 'BA1', 3),
(11, 'BA2', 3),
(12, 'BA3', 3),
(13, 'BA4', 4),
(14, 'BA5', 4),
(15, 'BA6', 4),
(16, 'BA7', 4),
(17, 'BA8', 5),
(18, 'BA9', 5),
(19, 'BA10', 5),
(20, 'BA11', 5),
(21, 'BA12', 5),
(22, 'BA13', 6),
(23, 'BA14', 6),
(24, 'BA15', 6),
(25, 'BA16', 6),
(26, 'BA17', 6),
(27, 'AA1', 7),
(28, 'AA2', 8),
(29, 'AA3', 9),
(30, 'AA4', 10),
(31, 'AA5', 7),
(32, 'AA6', 8),
(33, 'AA7', 9),
(34, 'AA8', 10),
(35, 'AA9', 7),
(36, 'AA10', 8),
(37, 'AA11', 9),
(38, 'AA12', 10),
(39, 'AA13', 7),
(40, 'AA14', 8),
(41, 'AA15', 9),
(42, 'AA16', 10),
(43, 'AA17', 7),
(44, 'AA18', 8),
(45, 'AA19', 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `cod_vuelo` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `cod_reserva` varchar(8) DEFAULT NULL,
  `estacion_origen` int(11) DEFAULT NULL,
  `estacion_destino` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `cod_vuelo`, `cantidad`, `id_usuario`, `cod_reserva`, `estacion_origen`, `estacion_destino`) VALUES
(1, 1, 20, 1, NULL, NULL, NULL),
(2, 1, 5, 2, NULL, NULL, NULL),
(3, 3, 1, 2, NULL, 1, 5),
(6, 1, 10, 2, NULL, NULL, NULL),
(9, 1, 15, 2, NULL, NULL, NULL),
(10, 1, 2, 2, NULL, NULL, NULL),
(11, 37, 1, 2, NULL, NULL, NULL),
(12, 37, 1, 2, NULL, NULL, NULL),
(13, 37, 1, 2, NULL, NULL, NULL),
(14, NULL, 2, NULL, NULL, NULL, NULL),
(15, NULL, 2, NULL, NULL, NULL, NULL),
(16, 1, 2, 2, NULL, NULL, NULL),
(17, 1, 2, 2, NULL, NULL, NULL),
(18, 38, 10, 2, NULL, NULL, NULL),
(19, 38, 1, 2, NULL, NULL, NULL),
(34, 40, 3, 1, NULL, 1, 4),
(35, 40, 7, 2, NULL, 3, 6),
(36, 40, 6, 2, NULL, 3, 5),
(37, 40, 1, 1, NULL, 1, 5),
(38, 40, 3, 1, NULL, 1, 6),
(39, 40, 2, 1, NULL, 4, 5),
(40, 40, 1, 2, NULL, 5, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `rol` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `rol`) VALUES
(1, 'Administrador'),
(2, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_viajes`
--

CREATE TABLE `tipo_viajes` (
  `id` int(11) NOT NULL,
  `tipo_viaje` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_viajes`
--

INSERT INTO `tipo_viajes` (`id`, `tipo_viaje`) VALUES
(1, 'Tour'),
(2, 'Suborbitales'),
(3, 'Entre destinos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(15) DEFAULT NULL,
  `apellido` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`) VALUES
(1, 'Tomas', 'Seijas', 'tomas.seijas10@gmail.com'),
(2, 'Sebastian', 'Dominikow', 'sebidomi@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes`
--

CREATE TABLE `viajes` (
  `id` int(11) NOT NULL,
  `tipo_viaje` int(11) DEFAULT NULL,
  `duracion` varchar(10) DEFAULT NULL,
  `fecha_salida` date NOT NULL,
  `hora_salida` time NOT NULL,
  `circuito_id` int(11) DEFAULT NULL,
  `nave` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `viajes`
--

INSERT INTO `viajes` (`id`, `tipo_viaje`, `duracion`, `fecha_salida`, `hora_salida`, `circuito_id`, `nave`) VALUES
(1, 1, '35 dias', '2019-11-10', '16:00:00', NULL, 34),
(2, 2, '8 horas', '2019-11-26', '03:00:00', NULL, 1),
(3, 2, '8 horas', '2019-11-24', '22:00:00', NULL, 3),
(4, 2, '8 horas', '2019-10-23', '15:00:00', NULL, 5),
(5, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 2),
(6, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 3),
(7, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 4),
(8, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 7),
(9, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 8),
(10, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 9),
(11, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 2),
(12, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 1),
(13, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 3),
(14, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 4),
(15, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 5),
(16, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 6),
(17, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 7),
(18, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 8),
(19, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 9),
(20, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 8),
(21, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 7),
(22, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 6),
(23, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 5),
(24, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 4),
(25, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 3),
(26, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 2),
(27, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 1),
(28, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 2),
(29, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 3),
(30, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 4),
(31, 2, '8 horas', '2019-10-23', '17:30:00', NULL, 5),
(32, 2, '8 horas', '2019-10-23', '02:00:00', NULL, 6),
(33, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 7),
(34, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 8),
(35, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 9),
(36, 2, '8 horas', '0000-00-00', '00:00:00', NULL, 8),
(37, 1, '35 dias', '2019-10-28', '00:00:00', NULL, 30),
(38, 1, '35 dias', '2019-11-03', '23:30:00', NULL, 38),
(39, 3, NULL, '0000-00-00', '00:00:00', 2, 21),
(40, 3, NULL, '2019-11-29', '00:10:00', 1, 19),
(41, 3, NULL, '0000-00-00', '00:00:00', 2, 18),
(42, 3, NULL, '0000-00-00', '00:00:00', 1, 17),
(43, 3, NULL, '0000-00-00', '00:00:00', 2, 16),
(44, 3, NULL, '0000-00-00', '00:00:00', 1, 15),
(45, 3, NULL, '0000-00-00', '00:00:00', 1, 35),
(46, 3, NULL, '0000-00-00', '00:00:00', 2, 40),
(47, 3, NULL, '0000-00-00', '00:00:00', 1, 24),
(48, 3, NULL, '0000-00-00', '00:00:00', 2, 13),
(49, 3, NULL, '0000-00-00', '00:00:00', 1, 19),
(50, 3, NULL, '2019-11-27', '22:00:00', 2, 24),
(51, 3, NULL, '0000-00-00', '00:00:00', 1, 12),
(52, 3, NULL, '0000-00-00', '00:00:00', 1, 32),
(53, 3, NULL, '0000-00-00', '00:00:00', 2, 22),
(54, 3, NULL, '2019-11-28', '20:00:00', 2, 45),
(55, 3, NULL, '0000-00-00', '00:00:00', 1, 15),
(56, 3, NULL, '0000-00-00', '00:00:00', 1, 20),
(57, 3, NULL, '2019-11-23', '12:45:00', 1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes_t`
--

CREATE TABLE `viajes_t` (
  `id` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `tipo_viaje` int(11) DEFAULT NULL,
  `origen` int(11) DEFAULT NULL,
  `destino` int(11) DEFAULT NULL,
  `duracion` varchar(15) DEFAULT NULL,
  `nave` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `viajes_t`
--

INSERT INTO `viajes_t` (`id`, `fecha`, `hora`, `tipo_viaje`, `origen`, `destino`, `duracion`, `nave`) VALUES
(1, '2019-11-02', '10:00:00', 1, 1, 1, '35 dias', 30),
(2, '2019-11-09', '10:00:00', 1, 1, 1, '35 dias', 34),
(3, '2019-11-16', '10:00:00', 1, 1, 1, '35 dias', 38),
(4, '2019-11-23', '10:00:00', 1, 1, 1, '35 dias', 42),
(5, '2019-11-30', '10:00:00', 1, 1, 1, '35 dias', 30),
(6, '2019-11-07', '10:00:00', 1, 1, 1, '35 dias', 34),
(7, '2019-11-14', '10:00:00', 1, 1, 1, '35 dias', 38),
(8, '2019-11-21', '10:00:00', 1, 1, 1, '35 dias', 42),
(9, '2019-10-29', '07:00:00', 2, 2, 2, '8 horas', 1),
(10, '2019-10-29', '09:00:00', 2, 1, 1, '8 horas', 6),
(11, '2019-10-29', '11:00:00', 2, 2, 2, '8 horas', 2),
(12, '2019-10-29', '13:00:00', 2, 1, 1, '8 horas', 3),
(13, '2019-10-29', '16:00:00', 2, 1, 1, '8 horas', 7),
(14, '2019-10-30', '07:00:00', 2, 2, 2, '8 horas', 1),
(15, '2019-10-30', '09:00:00', 2, 1, 1, '8 horas', 6),
(16, '2019-10-30', '11:00:00', 2, 2, 2, '8 horas', 2),
(17, '2019-10-30', '13:00:00', 2, 1, 1, '8 horas', 3),
(18, '2019-10-30', '16:00:00', 2, 1, 1, '8 horas', 7),
(19, '2019-10-31', '07:00:00', 2, 2, 2, '8 horas', 1),
(20, '2019-10-31', '09:00:00', 2, 1, 1, '8 horas', 6),
(21, '2019-10-31', '11:00:00', 2, 2, 2, '8 horas', 2),
(22, '2019-10-31', '13:00:00', 2, 1, 1, '8 horas', 3),
(23, '2019-10-31', '16:00:00', 2, 1, 1, '8 horas', 7),
(24, '2019-11-01', '07:00:00', 2, 2, 2, '8 horas', 1),
(25, '2019-11-01', '09:00:00', 2, 1, 1, '8 horas', 6),
(26, '2019-11-01', '11:00:00', 2, 2, 2, '8 horas', 2),
(27, '2019-11-01', '13:00:00', 2, 1, 1, '8 horas', 3),
(28, '2019-11-01', '16:00:00', 2, 1, 1, '8 horas', 7),
(29, '2019-11-02', '07:00:00', 2, 2, 2, '8 horas', 1),
(30, '2019-11-02', '09:00:00', 2, 1, 1, '8 horas', 6),
(31, '2019-11-02', '11:00:00', 2, 2, 2, '8 horas', 2),
(32, '2019-11-02', '13:00:00', 2, 1, 1, '8 horas', 3),
(33, '2019-11-02', '16:00:00', 2, 1, 1, '8 horas', 7),
(34, '2019-11-02', '13:00:00', 2, 2, 2, '8 horas', 4),
(35, '2019-11-02', '07:00:00', 2, 1, 1, '8 horas', 5),
(36, '2019-11-02', '11:00:00', 2, 1, 1, '8 horas', 8),
(37, '2019-11-03', '07:00:00', 2, 2, 2, '8 horas', 1),
(38, '2019-11-03', '09:00:00', 2, 1, 1, '8 horas', 6),
(39, '2019-11-03', '11:00:00', 2, 2, 2, '8 horas', 2),
(40, '2019-11-03', '13:00:00', 2, 1, 1, '8 horas', 3),
(41, '2019-11-03', '16:00:00', 2, 1, 1, '8 horas', 7),
(42, '2019-11-03', '13:00:00', 2, 2, 2, '8 horas', 4),
(43, '2019-11-03', '07:00:00', 2, 1, 1, '8 horas', 5),
(44, '2019-11-03', '11:00:00', 2, 1, 1, '8 horas', 8),
(45, '2019-11-03', '16:00:00', 2, 2, 2, '8 horas', 1),
(46, '2019-11-03', '14:00:00', 2, 1, 1, '8 horas', 9),
(47, '2019-11-04', '07:00:00', 2, 2, 2, '8 horas', 1),
(48, '2019-11-04', '09:00:00', 2, 1, 1, '8 horas', 6),
(49, '2019-11-04', '11:00:00', 2, 2, 2, '8 horas', 2),
(50, '2019-11-04', '13:00:00', 2, 1, 1, '8 horas', 3),
(51, '2019-11-04', '16:00:00', 2, 1, 1, '8 horas', 7),
(52, '2019-11-05', '07:00:00', 2, 2, 2, '8 horas', 1),
(53, '2019-11-05', '09:00:00', 2, 1, 1, '8 horas', 6),
(54, '2019-11-05', '11:00:00', 2, 2, 2, '8 horas', 2),
(55, '2019-11-05', '13:00:00', 2, 1, 1, '8 horas', 3),
(56, '2019-11-05', '16:00:00', 2, 1, 1, '8 horas', 7),
(57, '2019-11-06', '07:00:00', 2, 2, 2, '8 horas', 1),
(58, '2019-11-06', '09:00:00', 2, 1, 1, '8 horas', 6),
(59, '2019-11-06', '11:00:00', 2, 2, 2, '8 horas', 2),
(60, '2019-11-06', '13:00:00', 2, 1, 1, '8 horas', 3),
(61, '2019-11-06', '16:00:00', 2, 1, 1, '8 horas', 7),
(62, '2019-11-07', '07:00:00', 2, 2, 2, '8 horas', 1),
(63, '2019-11-07', '09:00:00', 2, 1, 1, '8 horas', 6),
(64, '2019-11-07', '11:00:00', 2, 2, 2, '8 horas', 2),
(65, '2019-11-07', '13:00:00', 2, 1, 1, '8 horas', 3),
(66, '2019-11-07', '16:00:00', 2, 1, 1, '8 horas', 7),
(67, '2019-11-08', '07:00:00', 2, 2, 2, '8 horas', 1),
(68, '2019-11-08', '09:00:00', 2, 1, 1, '8 horas', 6),
(69, '2019-11-08', '11:00:00', 2, 2, 2, '8 horas', 2),
(70, '2019-11-08', '13:00:00', 2, 1, 1, '8 horas', 3),
(71, '2019-11-08', '16:00:00', 2, 1, 1, '8 horas', 7),
(72, '2019-11-09', '07:00:00', 2, 2, 2, '8 horas', 1),
(73, '2019-11-09', '09:00:00', 2, 1, 1, '8 horas', 6),
(74, '2019-11-09', '11:00:00', 2, 2, 2, '8 horas', 2),
(75, '2019-11-09', '13:00:00', 2, 1, 1, '8 horas', 3),
(76, '2019-11-09', '16:00:00', 2, 1, 1, '8 horas', 7),
(77, '2019-11-09', '13:00:00', 2, 2, 2, '8 horas', 4),
(78, '2019-11-09', '07:00:00', 2, 1, 1, '8 horas', 5),
(79, '2019-11-09', '11:00:00', 2, 1, 1, '8 horas', 8),
(80, '2019-11-10', '07:00:00', 2, 2, 2, '8 horas', 1),
(81, '2019-11-10', '09:00:00', 2, 1, 1, '8 horas', 6),
(82, '2019-11-10', '11:00:00', 2, 2, 2, '8 horas', 2),
(83, '2019-11-10', '13:00:00', 2, 1, 1, '8 horas', 3),
(84, '2019-11-10', '16:00:00', 2, 1, 1, '8 horas', 7),
(85, '2019-11-10', '13:00:00', 2, 2, 2, '8 horas', 4),
(86, '2019-11-10', '07:00:00', 2, 1, 1, '8 horas', 5),
(87, '2019-11-10', '11:00:00', 2, 1, 1, '8 horas', 8),
(88, '2019-11-10', '16:00:00', 2, 2, 2, '8 horas', 1),
(89, '2019-11-10', '14:00:00', 2, 1, 1, '8 horas', 9),
(90, '2019-11-11', '07:00:00', 2, 2, 2, '8 horas', 1),
(91, '2019-11-11', '09:00:00', 2, 1, 1, '8 horas', 6),
(92, '2019-11-11', '11:00:00', 2, 2, 2, '8 horas', 2),
(93, '2019-11-11', '13:00:00', 2, 1, 1, '8 horas', 3),
(94, '2019-11-11', '16:00:00', 2, 1, 1, '8 horas', 7),
(95, '2019-11-12', '07:00:00', 2, 2, 2, '8 horas', 1),
(96, '2019-11-12', '09:00:00', 2, 1, 1, '8 horas', 6),
(97, '2019-11-12', '11:00:00', 2, 2, 2, '8 horas', 2),
(98, '2019-11-12', '13:00:00', 2, 1, 1, '8 horas', 3),
(99, '2019-11-12', '16:00:00', 2, 1, 1, '8 horas', 7),
(100, '2019-11-13', '07:00:00', 2, 2, 2, '8 horas', 1),
(101, '2019-11-13', '09:00:00', 2, 1, 1, '8 horas', 6),
(102, '2019-11-13', '11:00:00', 2, 2, 2, '8 horas', 2),
(103, '2019-11-13', '13:00:00', 2, 1, 1, '8 horas', 3),
(104, '2019-11-13', '16:00:00', 2, 1, 1, '8 horas', 7),
(105, '2019-11-14', '07:00:00', 2, 2, 2, '8 horas', 1),
(106, '2019-11-14', '09:00:00', 2, 1, 1, '8 horas', 6),
(107, '2019-11-14', '11:00:00', 2, 2, 2, '8 horas', 2),
(108, '2019-11-14', '13:00:00', 2, 1, 1, '8 horas', 3),
(109, '2019-11-14', '16:00:00', 2, 1, 1, '8 horas', 7),
(110, '2019-11-15', '07:00:00', 2, 2, 2, '8 horas', 1),
(111, '2019-11-15', '09:00:00', 2, 1, 1, '8 horas', 6),
(112, '2019-11-15', '11:00:00', 2, 2, 2, '8 horas', 2),
(113, '2019-11-15', '13:00:00', 2, 1, 1, '8 horas', 3),
(114, '2019-11-15', '16:00:00', 2, 1, 1, '8 horas', 7),
(115, '2019-11-16', '07:00:00', 2, 2, 2, '8 horas', 1),
(116, '2019-11-16', '09:00:00', 2, 1, 1, '8 horas', 6),
(117, '2019-11-16', '11:00:00', 2, 2, 2, '8 horas', 2),
(118, '2019-11-16', '13:00:00', 2, 1, 1, '8 horas', 3),
(119, '2019-11-16', '16:00:00', 2, 1, 1, '8 horas', 7),
(120, '2019-11-16', '13:00:00', 2, 2, 2, '8 horas', 4),
(121, '2019-11-16', '07:00:00', 2, 1, 1, '8 horas', 5),
(122, '2019-11-16', '11:00:00', 2, 1, 1, '8 horas', 8),
(123, '2019-11-17', '07:00:00', 2, 2, 2, '8 horas', 1),
(124, '2019-11-17', '09:00:00', 2, 1, 1, '8 horas', 6),
(125, '2019-11-17', '11:00:00', 2, 2, 2, '8 horas', 2),
(126, '2019-11-17', '13:00:00', 2, 1, 1, '8 horas', 3),
(127, '2019-11-17', '16:00:00', 2, 1, 1, '8 horas', 7),
(128, '2019-11-17', '13:00:00', 2, 2, 2, '8 horas', 4),
(129, '2019-11-17', '07:00:00', 2, 1, 1, '8 horas', 5),
(130, '2019-11-17', '11:00:00', 2, 1, 1, '8 horas', 8),
(131, '2019-11-17', '16:00:00', 2, 2, 2, '8 horas', 1),
(132, '2019-11-17', '14:00:00', 2, 1, 1, '8 horas', 9),
(133, '2019-11-18', '07:00:00', 2, 2, 2, '8 horas', 1),
(134, '2019-11-18', '09:00:00', 2, 1, 1, '8 horas', 6),
(135, '2019-11-18', '11:00:00', 2, 2, 2, '8 horas', 2),
(136, '2019-11-18', '13:00:00', 2, 1, 1, '8 horas', 3),
(137, '2019-11-18', '16:00:00', 2, 1, 1, '8 horas', 7),
(138, '2019-11-19', '07:00:00', 2, 2, 2, '8 horas', 1),
(139, '2019-11-19', '09:00:00', 2, 1, 1, '8 horas', 6),
(140, '2019-11-19', '11:00:00', 2, 2, 2, '8 horas', 2),
(141, '2019-11-19', '13:00:00', 2, 1, 1, '8 horas', 3),
(142, '2019-11-19', '16:00:00', 2, 1, 1, '8 horas', 7),
(143, '2019-11-20', '07:00:00', 2, 2, 2, '8 horas', 1),
(144, '2019-11-20', '09:00:00', 2, 1, 1, '8 horas', 6),
(145, '2019-11-20', '11:00:00', 2, 2, 2, '8 horas', 2),
(146, '2019-11-20', '13:00:00', 2, 1, 1, '8 horas', 3),
(147, '2019-11-20', '16:00:00', 2, 1, 1, '8 horas', 7),
(148, '2019-11-21', '07:00:00', 2, 2, 2, '8 horas', 1),
(149, '2019-11-21', '09:00:00', 2, 1, 1, '8 horas', 6),
(150, '2019-11-21', '11:00:00', 2, 2, 2, '8 horas', 2),
(151, '2019-11-21', '13:00:00', 2, 1, 1, '8 horas', 3),
(152, '2019-11-21', '16:00:00', 2, 1, 1, '8 horas', 7),
(153, '2019-11-22', '07:00:00', 2, 2, 2, '8 horas', 1),
(154, '2019-11-22', '09:00:00', 2, 1, 1, '8 horas', 6),
(155, '2019-11-22', '11:00:00', 2, 2, 2, '8 horas', 2),
(156, '2019-11-22', '13:00:00', 2, 1, 1, '8 horas', 3),
(157, '2019-11-22', '16:00:00', 2, 1, 1, '8 horas', 7),
(158, '2019-11-23', '07:00:00', 2, 2, 2, '8 horas', 1),
(159, '2019-11-23', '09:00:00', 2, 1, 1, '8 horas', 6),
(160, '2019-11-23', '11:00:00', 2, 2, 2, '8 horas', 2),
(161, '2019-11-23', '13:00:00', 2, 1, 1, '8 horas', 3),
(162, '2019-11-23', '16:00:00', 2, 1, 1, '8 horas', 7),
(163, '2019-11-23', '13:00:00', 2, 2, 2, '8 horas', 4),
(164, '2019-11-23', '07:00:00', 2, 1, 1, '8 horas', 5),
(165, '2019-11-23', '11:00:00', 2, 1, 1, '8 horas', 8),
(166, '2019-11-24', '07:00:00', 2, 2, 2, '8 horas', 1),
(167, '2019-11-24', '09:00:00', 2, 1, 1, '8 horas', 6),
(168, '2019-11-24', '11:00:00', 2, 2, 2, '8 horas', 2),
(169, '2019-11-24', '13:00:00', 2, 1, 1, '8 horas', 3),
(170, '2019-11-24', '16:00:00', 2, 1, 1, '8 horas', 7),
(171, '2019-11-24', '13:00:00', 2, 2, 2, '8 horas', 4),
(172, '2019-11-24', '07:00:00', 2, 1, 1, '8 horas', 5),
(173, '2019-11-24', '11:00:00', 2, 1, 1, '8 horas', 8),
(174, '2019-11-24', '16:00:00', 2, 2, 2, '8 horas', 1),
(175, '2019-11-24', '14:00:00', 2, 1, 1, '8 horas', 9),
(176, '2019-11-25', '07:00:00', 2, 2, 2, '8 horas', 1),
(177, '2019-11-25', '09:00:00', 2, 1, 1, '8 horas', 6),
(178, '2019-11-25', '11:00:00', 2, 2, 2, '8 horas', 2),
(179, '2019-11-25', '13:00:00', 2, 1, 1, '8 horas', 3),
(180, '2019-11-25', '16:00:00', 2, 1, 1, '8 horas', 7),
(181, '2019-11-26', '07:00:00', 2, 2, 2, '8 horas', 1),
(182, '2019-11-26', '09:00:00', 2, 1, 1, '8 horas', 6),
(183, '2019-11-26', '11:00:00', 2, 2, 2, '8 horas', 2),
(184, '2019-11-26', '13:00:00', 2, 1, 1, '8 horas', 3),
(185, '2019-11-26', '16:00:00', 2, 1, 1, '8 horas', 7),
(186, '2019-11-27', '07:00:00', 2, 2, 2, '8 horas', 1),
(187, '2019-11-27', '09:00:00', 2, 1, 1, '8 horas', 6),
(188, '2019-11-27', '11:00:00', 2, 2, 2, '8 horas', 2),
(189, '2019-11-27', '13:00:00', 2, 1, 1, '8 horas', 3),
(190, '2019-11-27', '16:00:00', 2, 1, 1, '8 horas', 7),
(191, '2019-11-28', '07:00:00', 2, 2, 2, '8 horas', 1),
(192, '2019-11-28', '09:00:00', 2, 1, 1, '8 horas', 6),
(193, '2019-11-28', '11:00:00', 2, 2, 2, '8 horas', 2),
(194, '2019-11-28', '13:00:00', 2, 1, 1, '8 horas', 3),
(195, '2019-11-28', '16:00:00', 2, 1, 1, '8 horas', 7),
(196, '2019-11-29', '07:00:00', 2, 2, 2, '8 horas', 1),
(197, '2019-11-29', '09:00:00', 2, 1, 1, '8 horas', 6),
(198, '2019-11-29', '11:00:00', 2, 2, 2, '8 horas', 2),
(199, '2019-11-29', '13:00:00', 2, 1, 1, '8 horas', 3),
(200, '2019-11-29', '16:00:00', 2, 1, 1, '8 horas', 7),
(201, '2019-11-30', '07:00:00', 2, 2, 2, '8 horas', 1),
(202, '2019-11-30', '09:00:00', 2, 1, 1, '8 horas', 6),
(203, '2019-11-30', '11:00:00', 2, 2, 2, '8 horas', 2),
(204, '2019-11-30', '13:00:00', 2, 1, 1, '8 horas', 3),
(205, '2019-11-30', '16:00:00', 2, 1, 1, '8 horas', 7),
(206, '2019-11-30', '13:00:00', 2, 2, 2, '8 horas', 4),
(207, '2019-11-30', '07:00:00', 2, 1, 1, '8 horas', 5),
(208, '2019-11-30', '11:00:00', 2, 1, 1, '8 horas', 8),
(209, '2019-12-01', '07:00:00', 2, 2, 2, '8 horas', 1),
(210, '2019-12-01', '09:00:00', 2, 1, 1, '8 horas', 6),
(211, '2019-12-01', '11:00:00', 2, 2, 2, '8 horas', 2),
(212, '2019-12-01', '13:00:00', 2, 1, 1, '8 horas', 3),
(213, '2019-12-01', '16:00:00', 2, 1, 1, '8 horas', 7),
(214, '2019-12-01', '13:00:00', 2, 2, 2, '8 horas', 4),
(215, '2019-12-01', '07:00:00', 2, 1, 1, '8 horas', 5),
(216, '2019-12-01', '11:00:00', 2, 1, 1, '8 horas', 8),
(217, '2019-12-01', '16:00:00', 2, 2, 2, '8 horas', 1),
(218, '2019-12-01', '14:00:00', 2, 1, 1, '8 horas', 9),
(219, '2019-11-19', '10:00:00', 3, 1, 3, '4 horas', 10),
(220, '2019-11-19', '14:00:00', 3, 3, 4, '1 horas', 10),
(221, '2019-11-19', '15:00:00', 3, 4, 5, '16 horas', 10),
(222, '2019-11-20', '07:00:00', 3, 5, 6, '26 horas', 10),
(223, '2019-11-19', '16:00:00', 3, 1, 3, '4 horas', 22),
(224, '2019-11-19', '20:00:00', 3, 3, 4, '1 horas', 22),
(225, '2019-11-19', '21:00:00', 3, 4, 5, '16 horas', 22),
(226, '2019-11-20', '13:00:00', 3, 5, 6, '26 horas', 22),
(227, '2019-11-19', '10:00:00', 3, 6, 5, '26 horas', 12),
(228, '2019-11-20', '12:00:00', 3, 5, 4, '16 horas', 12),
(229, '2019-11-21', '04:00:00', 3, 4, 3, '1 horas', 12),
(230, '2019-11-21', '05:00:00', 3, 3, 1, '4 horas', 12),
(231, '2019-11-19', '16:00:00', 3, 6, 5, '26 horas', 23),
(232, '2019-11-20', '18:00:00', 3, 5, 4, '16 horas', 23),
(233, '2019-11-21', '10:00:00', 3, 4, 3, '1 horas', 23),
(234, '2019-11-21', '11:00:00', 3, 3, 1, '4 horas', 23),
(235, '2019-11-20', '10:00:00', 3, 1, 3, '3 horas', 27),
(236, '2019-11-20', '13:00:00', 3, 3, 4, '1 horas', 27),
(237, '2019-11-20', '14:00:00', 3, 4, 5, '9 horas', 27),
(238, '2019-11-20', '23:00:00', 3, 5, 6, '22 horas', 27),
(239, '2019-11-20', '16:00:00', 3, 1, 3, '3 horas', 28),
(240, '2019-11-20', '19:00:00', 3, 3, 4, '1 horas', 28),
(241, '2019-11-20', '20:00:00', 3, 4, 5, '9 horas', 28),
(242, '2019-11-21', '05:00:00', 3, 5, 6, '22 horas', 28),
(243, '2019-11-20', '10:00:00', 3, 6, 5, '22 horas', 29),
(244, '2019-11-21', '08:00:00', 3, 5, 4, '9 horas', 29),
(245, '2019-11-21', '17:00:00', 3, 4, 3, '1 horas', 29),
(246, '2019-11-21', '18:00:00', 3, 3, 1, '3 horas', 29),
(247, '2019-11-20', '16:00:00', 3, 6, 5, '22 horas', 35),
(248, '2019-11-20', '14:00:00', 3, 5, 4, '9 horas', 35),
(249, '2019-11-20', '23:00:00', 3, 4, 3, '1 horas', 35),
(250, '2019-11-21', '00:00:00', 3, 3, 1, '3 horas', 35),
(251, '2019-11-19', '10:00:00', 3, 2, 3, '4 horas', 13),
(252, '2019-11-19', '14:00:00', 3, 3, 4, '1 horas', 13),
(253, '2019-11-19', '15:00:00', 3, 4, 5, '16 horas', 13),
(254, '2019-11-20', '07:00:00', 3, 5, 6, '26 horas', 13),
(255, '2019-11-19', '16:00:00', 3, 2, 3, '4 horas', 18),
(256, '2019-11-19', '20:00:00', 3, 3, 4, '1 horas', 18),
(257, '2019-11-19', '21:00:00', 3, 4, 5, '16 horas', 18),
(258, '2019-11-20', '13:00:00', 3, 5, 6, '26 horas', 18),
(259, '2019-11-19', '10:00:00', 3, 6, 5, '26 horas', 17),
(260, '2019-11-20', '12:00:00', 3, 5, 4, '16 horas', 17),
(261, '2019-11-21', '04:00:00', 3, 4, 3, '1 horas', 17),
(262, '2019-11-21', '05:00:00', 3, 3, 2, '4 horas', 17),
(263, '2019-11-19', '16:00:00', 3, 6, 5, '26 horas', 19),
(264, '2019-11-20', '18:00:00', 3, 5, 4, '16 horas', 19),
(265, '2019-11-21', '10:00:00', 3, 4, 3, '1 horas', 19),
(266, '2019-11-21', '11:00:00', 3, 3, 2, '4 horas', 19),
(267, '2019-11-20', '10:00:00', 3, 2, 3, '3 horas', 36),
(268, '2019-11-20', '13:00:00', 3, 3, 4, '1 horas', 36),
(269, '2019-11-20', '14:00:00', 3, 4, 5, '9 horas', 36),
(270, '2019-11-20', '23:00:00', 3, 5, 6, '22 horas', 36),
(271, '2019-11-20', '16:00:00', 3, 2, 3, '3 horas', 37),
(272, '2019-11-20', '19:00:00', 3, 3, 4, '1 horas', 37),
(273, '2019-11-20', '20:00:00', 3, 4, 5, '9 horas', 37),
(274, '2019-11-21', '05:00:00', 3, 5, 6, '22 horas', 37),
(275, '2019-11-20', '10:00:00', 3, 6, 5, '22 horas', 43),
(276, '2019-11-21', '08:00:00', 3, 5, 4, '9 horas', 43),
(277, '2019-11-21', '17:00:00', 3, 4, 3, '1 horas', 43),
(278, '2019-11-21', '18:00:00', 3, 3, 2, '3 horas', 43),
(279, '2019-11-20', '16:00:00', 3, 6, 5, '22 horas', 44),
(280, '2019-11-20', '14:00:00', 3, 5, 4, '9 horas', 44),
(281, '2019-11-20', '23:00:00', 3, 4, 3, '1 horas', 44),
(282, '2019-11-21', '00:00:00', 3, 3, 2, '3 horas', 44),
(283, '2019-11-19', '10:00:00', 3, 1, 3, '4 horas', 11),
(284, '2019-11-19', '14:00:00', 3, 3, 5, '14 horas', 11),
(285, '2019-11-20', '04:00:00', 3, 5, 7, '48 horas', 11),
(286, '2019-11-22', '04:00:00', 3, 7, 8, '50 horas', 11),
(287, '2019-11-24', '06:00:00', 3, 8, 9, '51 horas', 11),
(288, '2019-11-26', '09:00:00', 3, 9, 10, '70 horas', 11),
(289, '2019-11-29', '07:00:00', 3, 10, 11, '77 horas', 11),
(290, '2019-11-19', '16:00:00', 3, 1, 3, '4 horas', 14),
(291, '2019-11-19', '20:00:00', 3, 3, 5, '14 horas', 14),
(292, '2019-11-20', '10:00:00', 3, 5, 7, '48 horas', 14),
(293, '2019-11-22', '10:00:00', 3, 7, 8, '50 horas', 14),
(294, '2019-11-24', '12:00:00', 3, 8, 9, '51 horas', 14),
(295, '2019-11-26', '15:00:00', 3, 9, 10, '70 horas', 14),
(296, '2019-11-29', '13:00:00', 3, 10, 11, '77 horas', 14),
(297, '2019-11-19', '10:00:00', 3, 11, 10, '77 horas', 15),
(298, '2019-11-22', '15:00:00', 3, 10, 9, '70 horas', 15),
(299, '2019-11-25', '13:00:00', 3, 9, 8, '51 horas', 15),
(300, '2019-11-27', '16:00:00', 3, 8, 7, '50 horas', 15),
(301, '2019-11-29', '18:00:00', 3, 7, 5, '48 horas', 15),
(302, '2019-12-01', '18:00:00', 3, 5, 3, '14 horas', 15),
(303, '2019-12-02', '08:00:00', 3, 3, 1, '4 horas', 15),
(304, '2019-11-19', '16:00:00', 3, 11, 10, '77 horas', 16),
(305, '2019-11-22', '21:00:00', 3, 10, 9, '70 horas', 16),
(306, '2019-11-25', '19:00:00', 3, 9, 8, '51 horas', 16),
(307, '2019-11-27', '22:00:00', 3, 8, 7, '50 horas', 16),
(308, '2019-11-29', '00:00:00', 3, 7, 5, '48 horas', 16),
(309, '2019-12-01', '00:00:00', 3, 5, 3, '14 horas', 16),
(310, '2019-12-01', '14:00:00', 3, 3, 1, '4 horas', 16),
(311, '2019-11-19', '10:00:00', 3, 2, 3, '4 horas', 31),
(312, '2019-11-19', '14:00:00', 3, 3, 5, '14 horas', 31),
(313, '2019-11-20', '04:00:00', 3, 5, 7, '48 horas', 31),
(314, '2019-11-22', '04:00:00', 3, 7, 8, '50 horas', 31),
(315, '2019-11-24', '06:00:00', 3, 8, 9, '51 horas', 31),
(316, '2019-11-26', '09:00:00', 3, 9, 10, '70 horas', 31),
(317, '2019-11-29', '07:00:00', 3, 10, 11, '77 horas', 31),
(318, '2019-11-19', '16:00:00', 3, 2, 3, '4 horas', 32),
(319, '2019-11-19', '20:00:00', 3, 3, 5, '14 horas', 32),
(320, '2019-11-20', '10:00:00', 3, 5, 7, '48 horas', 32),
(321, '2019-11-22', '10:00:00', 3, 7, 8, '50 horas', 32),
(322, '2019-11-24', '12:00:00', 3, 8, 9, '51 horas', 32),
(323, '2019-11-26', '15:00:00', 3, 9, 10, '70 horas', 32),
(324, '2019-11-29', '13:00:00', 3, 10, 11, '77 horas', 32),
(325, '2019-11-19', '10:00:00', 3, 11, 10, '77 horas', 33),
(326, '2019-11-22', '15:00:00', 3, 10, 9, '70 horas', 33),
(327, '2019-11-25', '13:00:00', 3, 9, 8, '51 horas', 33),
(328, '2019-11-27', '16:00:00', 3, 8, 7, '50 horas', 33),
(329, '2019-11-29', '18:00:00', 3, 7, 5, '48 horas', 33),
(330, '2019-12-01', '18:00:00', 3, 5, 3, '14 horas', 33),
(331, '2019-12-02', '08:00:00', 3, 3, 2, '4 horas', 33),
(332, '2019-11-19', '16:00:00', 3, 11, 10, '77 horas', 39),
(333, '2019-11-22', '21:00:00', 3, 10, 9, '70 horas', 39),
(334, '2019-11-25', '19:00:00', 3, 9, 8, '51 horas', 39),
(335, '2019-11-27', '22:00:00', 3, 8, 7, '50 horas', 39),
(336, '2019-11-29', '00:00:00', 3, 7, 5, '48 horas', 39),
(337, '2019-12-01', '00:00:00', 3, 5, 3, '14 horas', 39),
(338, '2019-12-01', '14:00:00', 3, 3, 2, '4 horas', 39);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `circuitos`
--
ALTER TABLE `circuitos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `circuitos_estaciones`
--
ALTER TABLE `circuitos_estaciones`
  ADD PRIMARY KEY (`circuito_id`,`estacion_id`),
  ADD KEY `estacion_id` (`estacion_id`);

--
-- Indices de la tabla `credenciales`
--
ALTER TABLE `credenciales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol` (`rol`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `estaciones`
--
ALTER TABLE `estaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modelos_naves`
--
ALTER TABLE `modelos_naves`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `naves`
--
ALTER TABLE `naves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modelo` (`modelo`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cod_vuelo` (`cod_vuelo`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `estacion_origen` (`estacion_origen`),
  ADD KEY `estacion_destino` (`estacion_destino`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_viajes`
--
ALTER TABLE `tipo_viajes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_viaje` (`tipo_viaje`),
  ADD KEY `circuito_id` (`circuito_id`),
  ADD KEY `nave` (`nave`);

--
-- Indices de la tabla `viajes_t`
--
ALTER TABLE `viajes_t`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_viaje` (`tipo_viaje`),
  ADD KEY `origen` (`origen`),
  ADD KEY `destino` (`destino`),
  ADD KEY `nave` (`nave`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `circuitos`
--
ALTER TABLE `circuitos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `credenciales`
--
ALTER TABLE `credenciales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estaciones`
--
ALTER TABLE `estaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `modelos_naves`
--
ALTER TABLE `modelos_naves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `naves`
--
ALTER TABLE `naves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_viajes`
--
ALTER TABLE `tipo_viajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `viajes`
--
ALTER TABLE `viajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `viajes_t`
--
ALTER TABLE `viajes_t`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `circuitos_estaciones`
--
ALTER TABLE `circuitos_estaciones`
  ADD CONSTRAINT `circuitos_estaciones_ibfk_1` FOREIGN KEY (`circuito_id`) REFERENCES `circuitos` (`id`),
  ADD CONSTRAINT `circuitos_estaciones_ibfk_2` FOREIGN KEY (`estacion_id`) REFERENCES `estaciones` (`id`);

--
-- Filtros para la tabla `credenciales`
--
ALTER TABLE `credenciales`
  ADD CONSTRAINT `credenciales_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `naves`
--
ALTER TABLE `naves`
  ADD CONSTRAINT `naves_ibfk_1` FOREIGN KEY (`modelo`) REFERENCES `modelos_naves` (`id`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`cod_vuelo`) REFERENCES `viajes` (`id`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `credenciales` (`id`),
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`estacion_origen`) REFERENCES `estaciones` (`id`),
  ADD CONSTRAINT `reservas_ibfk_4` FOREIGN KEY (`estacion_destino`) REFERENCES `estaciones` (`id`);

--
-- Filtros para la tabla `viajes_t`
--
ALTER TABLE `viajes_t`
  ADD CONSTRAINT `viajes_t_ibfk_1` FOREIGN KEY (`tipo_viaje`) REFERENCES `tipo_viajes` (`id`),
  ADD CONSTRAINT `viajes_t_ibfk_2` FOREIGN KEY (`origen`) REFERENCES `estaciones` (`id`),
  ADD CONSTRAINT `viajes_t_ibfk_3` FOREIGN KEY (`destino`) REFERENCES `estaciones` (`id`),
  ADD CONSTRAINT `viajes_t_ibfk_4` FOREIGN KEY (`nave`) REFERENCES `naves` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
