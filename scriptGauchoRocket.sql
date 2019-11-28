--
-- Base de datos: `gauchorocket`
--
CREATE DATABASE gauchorocket;
USE gauchorocket;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cabina`
--

CREATE TABLE `cabina` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cabina`
--

INSERT INTO `cabina` (`id`, `nombre`) VALUES
(1, 'General'),
(2, 'Familiar'),
(3, 'Suite');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capacidad`
--

CREATE TABLE `capacidad` (
  `id` int(11) NOT NULL,
  `modelo` int(11) DEFAULT NULL,
  `tipo_cabina` int(11) DEFAULT NULL,
  `filas` int(11) DEFAULT NULL,
  `columnas` int(11) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `capacidad`
--

INSERT INTO `capacidad` (`id`, `modelo`, `tipo_cabina`, `filas`, `columnas`, `precio`) VALUES
(1, 1, 1, 20, 10, 1000),
(2, 1, 2, 15, 5, 1500),
(3, 1, 3, 5, 5, 2500),
(4, 2, 1, 20, 5, 800),
(5, 2, 2, 9, 2, 1300),
(6, 2, 3, 1, 2, 2300),
(7, 3, 1, 10, 5, 1300),
(8, 3, 2, 10, 5, 3500),
(9, 4, 1, 11, 10, 1200),
(10, 5, 2, 10, 5, 2600),
(11, 5, 3, 5, 2, 3700),
(12, 6, 2, 14, 5, 2600),
(13, 6, 3, 5, 2, 3700),
(14, 7, 1, 20, 10, 1600),
(15, 7, 2, 15, 5, 3000),
(16, 7, 3, 5, 5, 4100),
(17, 8, 1, 30, 10, 1600),
(18, 8, 2, 5, 2, 3000),
(19, 8, 3, 8, 5, 4100),
(20, 9, 1, 15, 10, 1600),
(21, 9, 2, 5, 5, 3000),
(22, 9, 3, 5, 5, 4100),
(23, 10, 3, 10, 10, 10000),
(24, 10, 2, 10, 10, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centros_medicos`
--

CREATE TABLE `centros_medicos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `turnos_diarios` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `centros_medicos`
--

INSERT INTO `centros_medicos` (`id`, `nombre`, `turnos_diarios`) VALUES
(1, 'Buenos Aires', 300),
(2, 'Shanghai', 210),
(3, 'Ankara', 200);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `circuitos`
--

CREATE TABLE `circuitos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `circuitos`
--

INSERT INTO `circuitos` (`id`, `nombre`) VALUES
(1, 'Circuito 1 - Ida'),
(2, 'Circuito 2 - Ida'),
(3, 'Bs As'),
(4, 'Ankara'),
(5, 'Circuito 1 - Vuelta'),
(6, 'Circuito 2 - Vuelta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `circuitos_estaciones`
--

CREATE TABLE `circuitos_estaciones` (
  `circuito_id` int(11) NOT NULL,
  `estacion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(2, 11),
(3, 1),
(4, 2),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(6, 1),
(6, 2),
(6, 3),
(6, 5),
(6, 7),
(6, 8),
(6, 9),
(6, 10),
(6, 11);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `credenciales`
--

INSERT INTO `credenciales` (`id`, `usuario`, `rol`, `clave`, `id_usuario`) VALUES
(1, 'Tomas', 1, '81dc9bdb52d04dc20036dbd8313ed055', 1),
(2, 'Sebastian', 2, '81dc9bdb52d04dc20036dbd8313ed055', 2),
(8, 'gallo', 2, '81dc9bdb52d04dc20036dbd8313ed055', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estaciones`
--

CREATE TABLE `estaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Estructura de tabla para la tabla `meses`
--

CREATE TABLE `meses` (
  `id` int(11) NOT NULL,
  `meses` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `meses`
--

INSERT INTO `meses` (`id`, `meses`) VALUES
(1, '01'),
(2, '02'),
(3, '03'),
(4, '04'),
(5, '05'),
(6, '06'),
(7, '07'),
(8, '08'),
(9, '09'),
(10, '10'),
(11, '11'),
(12, '12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelos_naves`
--

CREATE TABLE `modelos_naves` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `estacion_destino` int(11) DEFAULT NULL,
  `idCapacidadCabina` int(11) DEFAULT NULL,
  `lista_espera` tinyint(1) DEFAULT NULL,
  `pago` tinyint(1) DEFAULT NULL,
  `check_in` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `cod_vuelo`, `cantidad`, `id_usuario`, `cod_reserva`, `estacion_origen`, `estacion_destino`, `idCapacidadCabina`, `lista_espera`, `pago`, `check_in`) VALUES
(1, 1, 20, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 1, 2, 2, 'ABC123', 1, 1, 24, NULL, NULL, NULL),
(42, 11, 3, NULL, 'CR15', NULL, NULL, 2, NULL, NULL, NULL),
(45, 8, 88, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 4, 77, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 20, 5, 1, NULL, 1, 8, NULL, NULL, NULL, NULL),
(90, 20, 4, 1, NULL, 8, 9, NULL, NULL, NULL, NULL),
(91, 1, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 1, 8, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 1, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(94, 8, 10, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(95, 4, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(96, 11, 10, 1, NULL, 3, 6, NULL, NULL, NULL, NULL),
(97, 19, 5, 1, NULL, 3, 10, NULL, NULL, NULL, NULL),
(98, 14, 10, 1, NULL, 6, 4, NULL, NULL, NULL, NULL),
(99, 27, 5, 1, NULL, 9, 5, NULL, NULL, NULL, NULL),
(100, 1, 6, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 10, 1, 1, NULL, 1, 4, NULL, NULL, NULL, NULL),
(106, 1, 54, 1, NULL, NULL, NULL, 23, NULL, NULL, NULL),
(109, 1, 3, 1, NULL, NULL, NULL, 23, NULL, NULL, NULL),
(110, 1, 43, 1, NULL, NULL, NULL, 23, NULL, NULL, NULL),
(111, 5, 10, 1, NULL, NULL, NULL, 4, NULL, NULL, NULL),
(112, 5, 15, 1, NULL, NULL, NULL, 5, NULL, NULL, NULL),
(113, 5, 2, 1, NULL, NULL, NULL, 6, NULL, NULL, NULL),
(114, 10, 10, 1, NULL, 1, 4, 12, NULL, NULL, NULL),
(115, 10, 10, 1, NULL, 1, 4, 13, NULL, NULL, NULL),
(116, 1, 2, 1, NULL, NULL, NULL, 23, 1, NULL, NULL),
(117, 10, 3, 1, NULL, 1, 4, 13, 1, NULL, NULL),
(118, 1, 3, 1, NULL, NULL, NULL, 23, 1, NULL, NULL),
(119, 1, 1, 1, NULL, NULL, NULL, 23, 1, NULL, NULL),
(120, 1, 1, 1, NULL, NULL, NULL, 23, 1, NULL, NULL),
(121, 1, 1, 1, NULL, NULL, NULL, 23, 1, NULL, NULL),
(122, 10, 1, 1, NULL, 1, 4, 12, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `rol` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `rol`) VALUES
(1, 'Administrador'),
(2, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjetas_credito`
--

CREATE TABLE `tarjetas_credito` (
  `id` int(11) NOT NULL,
  `tipo_tarjeta` varchar(30) DEFAULT NULL,
  `validacion_tarjeta` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tarjetas_credito`
--

INSERT INTO `tarjetas_credito` (`id`, `tipo_tarjeta`, `validacion_tarjeta`) VALUES
(1, 'American Express', '/^([34|37]{2})([0-9]{13})$/'),
(2, 'Visa', '/^([4]{1})([0-9]{12,15})$/'),
(3, 'MasterCard', '/^([51|52|53|54|55]{2})([0-9]{14})$/');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_viajes`
--

CREATE TABLE `tipo_viajes` (
  `id` int(11) NOT NULL,
  `tipo_viaje` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_viajes`
--

INSERT INTO `tipo_viajes` (`id`, `tipo_viaje`) VALUES
(1, 'Tour'),
(2, 'Suborbitales'),
(3, 'Entre destinos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `centro_medico` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `id` int(11) NOT NULL,
  `codigo_vuelo` varchar(7) DEFAULT NULL,
  `codigo_reserva` varchar(7) DEFAULT NULL,
  `asiento` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`id`, `codigo_vuelo`, `codigo_reserva`, `asiento`) VALUES
(113, 'ED512-I', 'O51U2Z9', 'c2f1'),
(114, 'ED512-I', 'O51U2Z9', 'c5f1'),
(115, 'ED512-I', 'O51U2Z9', 'c6f1'),
(116, 'ED512-I', 'O51U2Z9', 'c3f1'),
(119, 'ED512-I', 'O51U2Z9', 'c6f3'),
(120, 'ED512-I', 'O51U2Z9', 'c3f4'),
(121, 'ED512-I', 'O51U2Z9', 'c5f5'),
(122, 'ED512-I', 'O51U2Z9', 'c2f21'),
(123, 'ED512-I', 'O51U2Z9', 'c3f21'),
(147, 'ED512-I', 'O51U2Z9', 'c10f1'),
(148, 'ED512-I', 'O51U2Z9', 'c11f1'),
(149, 'ED512-I', 'O51U2Z9', 'c12f1'),
(150, 'ED512-I', 'O51U2Z9', 'c13f1'),
(151, NULL, '79MN5', 'c3f1'),
(170, NULL, 'SSS', 'c2f13'),
(171, NULL, 'SSS', 'c3f13'),
(172, NULL, 'SSS', 'c4f13'),
(173, NULL, 'SSS', 'c5f13'),
(174, NULL, 'SSS', 'c2f14'),
(175, NULL, 'SSS', 'c3f14'),
(176, NULL, 'SSS', 'c4f14'),
(177, NULL, 'SSS', 'c5f14'),
(178, NULL, 'CR15', 'c4f13'),
(179, NULL, 'CR15', 'c3f14'),
(180, NULL, 'CR15', 'c4f14'),
(181, NULL, 'CR15', 'c2f11'),
(182, NULL, 'CR15', 'c3f11'),
(183, NULL, 'CR15', 'c2f12'),
(184, NULL, 'CR15', 'c4f2'),
(185, NULL, 'CR15', 'c3f3'),
(186, NULL, 'CR15', 'c5f3'),
(187, NULL, 'CR15', 'c4f2'),
(188, NULL, 'CR15', 'c3f3'),
(189, NULL, 'CR15', 'c5f3'),
(190, NULL, 'CR15', 'c3f1'),
(191, NULL, 'CR15', 'c4f1'),
(192, NULL, 'CR15', 'c5f1'),
(193, NULL, 'CR15', 'c1f1'),
(194, NULL, 'CR15', 'c1f2'),
(195, NULL, 'CR15', 'c1f3'),
(196, NULL, 'CR15', 'c3f4'),
(197, NULL, 'CR15', 'c2f5'),
(198, NULL, 'CR15', 'c4f5'),
(199, NULL, 'CR15', 'c5f8'),
(200, NULL, 'CR15', 'c4f9'),
(201, NULL, 'CR15', 'c5f9');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(15) DEFAULT NULL,
  `apellido` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `nivel_vuelo` int(11) DEFAULT NULL,
  `se_chequeo` tinyint(4) DEFAULT NULL,
  `confirmacion_mail` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `nivel_vuelo`, `se_chequeo`, `confirmacion_mail`) VALUES
(1, 'Tomas', 'Seijas', 'tomas.seijas10@gmail.com', NULL, 1, 1),
(2, 'Sebastian', 'Dominikow', 'sebidomi@hotmail.com', NULL, 0, 1),
(4, 'bbb', 'bbbbbb', 'bbbbb@bbbbb.bbb', NULL, NULL, 0),
(5, 'Juan', 'Lopez', 'juan19@gmail.com', NULL, NULL, 0),
(6, 'aa', 'ss', 'galloclaudio69@gmail.com', NULL, NULL, NULL),
(7, 'cccc', 'ccccccccc', 'ccccc@ccccc.ccc', NULL, NULL, 0),
(8, '', '', '', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes`
--

CREATE TABLE `viajes` (
  `id` int(11) NOT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `tipo_viaje` int(11) DEFAULT NULL,
  `duracion` varchar(15) DEFAULT NULL,
  `nave` int(11) DEFAULT NULL,
  `circuito_id` int(11) DEFAULT NULL,
  `codigo_vuelo` varchar(7) DEFAULT NULL,
  `origen` int(11) DEFAULT NULL,
  `destino` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `viajes`
--

INSERT INTO `viajes` (`id`, `fecha_hora`, `tipo_viaje`, `duracion`, `nave`, `circuito_id`, `codigo_vuelo`, `origen`, `destino`) VALUES
(1, '2019-11-17 10:00:00', 1, '35 dias', 30, 3, 'TR236', 1, 1),
(2, '2019-11-16 07:00:00', 2, '8 horas', 1, 4, 'OR155', 2, 2),
(3, '2019-11-16 09:00:00', 2, '8 horas', 6, 3, 'OR172', 1, 1),
(4, '2019-11-16 11:00:00', 2, '8 horas', 2, 4, 'OR784', 2, 2),
(5, '2019-11-16 13:00:00', 2, '8 horas', 3, 3, 'OR634', 1, 1),
(6, '2019-11-16 16:00:00', 2, '8 horas', 7, 3, 'OR811', 1, 1),
(7, '2019-11-16 13:00:00', 2, '8 horas', 4, 4, 'OR235', 2, 2),
(8, '2019-11-16 07:00:00', 2, '8 horas', 5, 3, 'OR641', 1, 1),
(9, '2019-11-16 11:00:00', 2, '8 horas', 8, 3, 'OR369', 1, 1),
(10, '2019-11-20 16:00:00', 3, '4 horas', 22, 1, 'ED612-I', 1, 3),
(11, '2019-11-20 20:00:00', 3, '1 horas', 22, 1, 'ED612-I', 3, 4),
(12, '2019-11-20 21:00:00', 3, '16 horas', 22, 1, 'ED612-I', 4, 5),
(13, '2019-11-21 13:00:00', 3, '26 horas', 22, 1, 'ED612-I', 5, 6),
(14, '2019-11-19 10:00:00', 3, '26 horas', 12, 5, 'ED389-V', 6, 5),
(15, '2019-11-20 12:00:00', 3, '16 horas', 12, 5, 'ED389-V', 5, 4),
(16, '2019-11-21 04:00:00', 3, '1 horas', 12, 5, 'ED389-V', 4, 3),
(17, '2019-11-21 05:00:00', 3, '4 horas', 12, 5, 'ED389-V', 3, 1),
(18, '2019-11-19 16:00:00', 3, '4 horas', 32, 2, 'ED951-I', 1, 3),
(19, '2019-11-19 20:00:00', 3, '14 horas', 32, 2, 'ED951-I', 3, 5),
(20, '2019-11-20 10:00:00', 3, '48 horas', 32, 2, 'ED951-I', 5, 7),
(21, '2019-11-22 10:00:00', 3, '50 horas', 32, 2, 'ED951-I', 7, 8),
(22, '2019-11-24 12:00:00', 3, '51 horas', 32, 2, 'ED951-I', 8, 9),
(23, '2019-11-26 15:00:00', 3, '70 horas', 32, 2, 'ED951-I', 9, 10),
(24, '2019-11-29 13:00:00', 3, '77 horas', 32, 2, 'ED951-I', 10, 11),
(25, '2019-11-19 10:00:00', 3, '77 horas', 33, 6, 'ED803-V', 11, 10),
(26, '2019-11-22 15:00:00', 3, '70 horas', 33, 6, 'ED803-V', 10, 9),
(27, '2019-11-25 13:00:00', 3, '51 horas', 33, 6, 'ED803-V', 9, 8),
(28, '2019-11-27 16:00:00', 3, '50 horas', 33, 6, 'ED803-V', 8, 7),
(29, '2019-11-29 18:00:00', 3, '48 horas', 33, 6, 'ED803-V', 7, 5),
(30, '2019-12-01 18:00:00', 3, '14 horas', 33, 6, 'ED803-V', 5, 3),
(31, '2019-12-02 08:00:00', 3, '4 horas', 33, 6, 'ED803-V', 3, 1),
(32, NULL, NULL, NULL, NULL, NULL, '523', NULL, NULL),
(76, '2019-11-21 22:00:00', NULL, NULL, NULL, NULL, 'CERATTI', NULL, NULL),
(77, '2019-11-22 03:00:00', NULL, NULL, NULL, NULL, 'CERATTI', NULL, NULL),
(78, '2019-11-22 08:00:00', NULL, NULL, NULL, NULL, 'CERATTI', NULL, NULL),
(79, '2019-11-20 10:00:00', 3, 'medio dia', 10, 5, 'J8', 5, 3),
(80, '2019-11-20 10:00:00', 3, 'medio dia', 11, 6, 'J9', 5, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cabina`
--
ALTER TABLE `cabina`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `capacidad`
--
ALTER TABLE `capacidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modelo` (`modelo`),
  ADD KEY `tipo_cabina` (`tipo_cabina`);

--
-- Indices de la tabla `centros_medicos`
--
ALTER TABLE `centros_medicos`
  ADD PRIMARY KEY (`id`);

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
-- Indices de la tabla `meses`
--
ALTER TABLE `meses`
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
-- Indices de la tabla `tarjetas_credito`
--
ALTER TABLE `tarjetas_credito`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_viajes`
--
ALTER TABLE `tipo_viajes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `centro_medico` (`centro_medico`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
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
  ADD KEY `circuitos` (`circuito_id`),
  ADD KEY `origen` (`origen`),
  ADD KEY `destino` (`destino`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cabina`
--
ALTER TABLE `cabina`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `capacidad`
--
ALTER TABLE `capacidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `centros_medicos`
--
ALTER TABLE `centros_medicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `circuitos`
--
ALTER TABLE `circuitos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `credenciales`
--
ALTER TABLE `credenciales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `estaciones`
--
ALTER TABLE `estaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `meses`
--
ALTER TABLE `meses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tarjetas_credito`
--
ALTER TABLE `tarjetas_credito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_viajes`
--
ALTER TABLE `tipo_viajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `viajes`
--
ALTER TABLE `viajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `capacidad`
--
ALTER TABLE `capacidad`
  ADD CONSTRAINT `capacidad_ibfk_1` FOREIGN KEY (`modelo`) REFERENCES `modelos_naves` (`id`),
  ADD CONSTRAINT `capacidad_ibfk_2` FOREIGN KEY (`tipo_cabina`) REFERENCES `cabina` (`id`);

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
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `turnos_ibfk_2` FOREIGN KEY (`centro_medico`) REFERENCES `centros_medicos` (`id`);

--
-- Filtros para la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD CONSTRAINT `viajes_ibfk_1` FOREIGN KEY (`tipo_viaje`) REFERENCES `tipo_viajes` (`id`),
  ADD CONSTRAINT `viajes_ibfk_2` FOREIGN KEY (`circuito_id`) REFERENCES `circuitos` (`id`),
  ADD CONSTRAINT `viajes_ibfk_3` FOREIGN KEY (`origen`) REFERENCES `estaciones` (`id`),
  ADD CONSTRAINT `viajes_ibfk_4` FOREIGN KEY (`destino`) REFERENCES `estaciones` (`id`);
COMMIT;