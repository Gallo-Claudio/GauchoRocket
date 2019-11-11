-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 05-11-2019 a las 02:57:27
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `elbrote`
--
CREATE DATABASE IF NOT EXISTS `elbrote` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `elbrote`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `dni` varchar(30) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `idObraSocial` int(11) NOT NULL,
  `direccion` varchar(300) NOT NULL,
  `afiliado` int(11) NOT NULL,
  `fechaNacimiento` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `idObraSocial`, `direccion`, `afiliado`, `fechaNacimiento`) VALUES
(1, 'Micaela', 'Ramirez', '458252214', '45252552', 3, 'El Jilguero 2459 Paso del Rey', 8875544, '1559685600'),
(2, 'Celeste', 'Maciel', '458252214', '45252552', 1, 'El Jilguero 2459 Paso del Rey', 444555, '1559685600'),
(16, 'Andrea', 'Fernandez', '45254245', '4525211', 1, 'Lavalle 245', 2147483647, '1167778800');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobranza`
--

CREATE TABLE `cobranza` (
  `id` int(11) NOT NULL,
  `id_obrasocial` int(11) NOT NULL,
  `nro_recibo` int(11) NOT NULL,
  `fecha` varchar(100) NOT NULL,
  `nro_factura` varchar(100) NOT NULL,
  `monto_efectivo` double NOT NULL,
  `monto_cheque` double NOT NULL,
  `nro_cheque` int(11) NOT NULL,
  `banco_cheque` varchar(200) NOT NULL,
  `fecha_cheque` varchar(100) NOT NULL,
  `montoTransferencia` double NOT NULL,
  `fechaTransferencia` varchar(100) NOT NULL,
  `bancoTransferencia` varchar(200) NOT NULL,
  `cuentaAcreditacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cobranza`
--

INSERT INTO `cobranza` (`id`, `id_obrasocial`, `nro_recibo`, `fecha`, `nro_factura`, `monto_efectivo`, `monto_cheque`, `nro_cheque`, `banco_cheque`, `fecha_cheque`, `montoTransferencia`, `fechaTransferencia`, `bancoTransferencia`, `cuentaAcreditacion`) VALUES
(3, 0, 1, '1561240800', '7,10', 20000, 20000, 2147483647, '', '2019-06-20', 55000, '2019-06-21', 'Banco Frances', '452178854/8');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `idFactura` int(11) NOT NULL,
  `periodo` varchar(200) NOT NULL,
  `monto` double NOT NULL,
  `alumno` varchar(100) NOT NULL,
  `obraSocial` varchar(150) NOT NULL,
  `fecha` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`idFactura`, `periodo`, `monto`, `alumno`, `obraSocial`, `fecha`, `estado`) VALUES
(7, 'marzo-abril de 2019', 50000, 'Fernanda Anzoaga', '3', '12542122252', 1),
(9, 'marzo-abril de 2019', 50000, 'Florencia Gomez ', '1', '1561240800', 0),
(10, 'marzo-abril de 2019', 45000, 'Chris Love', '3', '1561240800', 1),
(11, 'Junio-julio 2019', 50000, 'Celeste Maciel', '5', '1561240800', 0),
(12, 'asd', 0, 'sda', '0', '1572303600', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notadecredito`
--

CREATE TABLE `notadecredito` (
  `idNota` int(100) NOT NULL,
  `fecha` varchar(200) NOT NULL,
  `obraSocial` varchar(150) NOT NULL,
  `numeroFactura` int(100) NOT NULL,
  `monto` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `notadecredito`
--

INSERT INTO `notadecredito` (`idNota`, `fecha`, `obraSocial`, `numeroFactura`, `monto`) VALUES
(3, '2019-06-22', 'OSDE', 7, 50000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obrasocial`
--

CREATE TABLE `obrasocial` (
  `id` int(11) NOT NULL,
  `cuit` varchar(50) NOT NULL,
  `razonSocial` varchar(100) NOT NULL,
  `condicionIVA` varchar(50) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `direccion` varchar(300) NOT NULL,
  `localidad` varchar(100) NOT NULL,
  `cp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `obrasocial`
--

INSERT INTO `obrasocial` (`id`, `cuit`, `razonSocial`, `condicionIVA`, `telefono`, `email`, `direccion`, `localidad`, `cp`) VALUES
(1, '30546741258', 'OSDE', 'Responsable Inscripto', '4521-5288', 'info@osde.com.ar', 'Av. Leandro N Alem 1067', 'CABA', 1050),
(2, '30550273558', 'OSECAC', 'Responsable Inscripto', '78559966', 'info@osecac.com.ar', ' R.S.PEÃ‘A 530 ', 'CAVA', 1055),
(3, '30125421521', 'Omint SRL', 'Responsable Inscripto', '011 7855 5212', 'info@omint.com.ar', 'Carlos Pellegrini 1524', 'CABA', 1050),
(5, '4512542142', 'IOMA', 'Responsable Inscripto', '011 52452222', 'info@ioma.com.ar', 'Calle 13 5242', 'La Plata', 1900);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recibo`
--

CREATE TABLE `recibo` (
  `idRecibo` int(25) NOT NULL,
  `numeroFactura` int(25) NOT NULL,
  `fecha` varchar(150) NOT NULL,
  `monto` int(50) NOT NULL,
  `obraSocial` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `recibo`
--

INSERT INTO `recibo` (`idRecibo`, `numeroFactura`, `fecha`, `monto`, `obraSocial`) VALUES
(3, 7, '2019-06-22', 50000, 'Omint');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cobranza`
--
ALTER TABLE `cobranza`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`idFactura`);

--
-- Indices de la tabla `notadecredito`
--
ALTER TABLE `notadecredito`
  ADD PRIMARY KEY (`idNota`);

--
-- Indices de la tabla `obrasocial`
--
ALTER TABLE `obrasocial`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recibo`
--
ALTER TABLE `recibo`
  ADD PRIMARY KEY (`idRecibo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `cobranza`
--
ALTER TABLE `cobranza`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `idFactura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `notadecredito`
--
ALTER TABLE `notadecredito`
  MODIFY `idNota` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `obrasocial`
--
ALTER TABLE `obrasocial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `recibo`
--
ALTER TABLE `recibo`
  MODIFY `idRecibo` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Base de datos: `gauchorocket`
--
CREATE DATABASE IF NOT EXISTS `gauchorocket` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gauchorocket`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centros_medicos`
--

CREATE TABLE `centros_medicos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `turnos_diarios` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `circuitos`
--

INSERT INTO `circuitos` (`id`, `nombre`) VALUES
(1, 'Circuito 1'),
(2, 'Circuito 2'),
(3, 'Bs As'),
(4, 'Ankara');

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
(2, 11),
(3, 1),
(4, 2);

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
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `centro_medico` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `se_chequeo` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `nivel_vuelo`, `se_chequeo`) VALUES
(1, 'Tomas', 'Seijas', 'tomas.seijas10@gmail.com', NULL, 1),
(2, 'Sebastian', 'Dominikow', 'sebidomi@hotmail.com', NULL, 0);

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
  `nave` int(11) DEFAULT NULL,
  `codigo_vuelo` varchar(8) DEFAULT NULL,
  `circuitos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `viajes_t`
--

INSERT INTO `viajes_t` (`id`, `fecha`, `hora`, `tipo_viaje`, `origen`, `destino`, `duracion`, `nave`, `codigo_vuelo`, `circuitos`) VALUES
(1, '2019-11-02', '10:00:00', 1, 1, 1, '35 dias', 30, NULL, 3),
(2, '2019-11-09', '10:00:00', 1, 1, 1, '35 dias', 34, NULL, 3),
(3, '2019-11-16', '10:00:00', 1, 1, 1, '35 dias', 38, NULL, 3),
(4, '2019-11-23', '10:00:00', 1, 1, 1, '35 dias', 42, NULL, 3),
(5, '2019-11-30', '10:00:00', 1, 1, 1, '35 dias', 30, NULL, 3),
(6, '2019-11-07', '10:00:00', 1, 1, 1, '35 dias', 34, NULL, 3),
(7, '2019-11-14', '10:00:00', 1, 1, 1, '35 dias', 38, NULL, 3),
(8, '2019-11-21', '10:00:00', 1, 1, 1, '35 dias', 42, NULL, 3),
(9, '2019-10-29', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(10, '2019-10-29', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(11, '2019-10-29', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(12, '2019-10-29', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(13, '2019-10-29', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(14, '2019-10-30', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(15, '2019-10-30', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(16, '2019-10-30', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(17, '2019-10-30', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(18, '2019-10-30', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(19, '2019-10-31', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(20, '2019-10-31', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(21, '2019-10-31', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(22, '2019-10-31', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(23, '2019-10-31', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(24, '2019-11-01', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(25, '2019-11-01', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(26, '2019-11-01', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(27, '2019-11-01', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(28, '2019-11-01', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(29, '2019-11-02', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(30, '2019-11-02', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(31, '2019-11-02', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(32, '2019-11-02', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(33, '2019-11-02', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(34, '2019-11-02', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(35, '2019-11-02', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(36, '2019-11-02', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(37, '2019-11-03', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(38, '2019-11-03', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(39, '2019-11-03', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(40, '2019-11-03', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(41, '2019-11-03', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(42, '2019-11-03', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(43, '2019-11-03', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(44, '2019-11-03', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(45, '2019-11-03', '16:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(46, '2019-11-03', '14:00:00', 2, 1, 1, '8 horas', 9, NULL, NULL),
(47, '2019-11-04', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(48, '2019-11-04', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(49, '2019-11-04', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(50, '2019-11-04', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(51, '2019-11-04', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(52, '2019-11-05', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(53, '2019-11-05', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(54, '2019-11-05', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(55, '2019-11-05', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(56, '2019-11-05', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(57, '2019-11-06', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(58, '2019-11-06', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(59, '2019-11-06', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(60, '2019-11-06', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(61, '2019-11-06', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(62, '2019-11-07', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(63, '2019-11-07', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(64, '2019-11-07', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(65, '2019-11-07', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(66, '2019-11-07', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(67, '2019-11-08', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(68, '2019-11-08', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(69, '2019-11-08', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(70, '2019-11-08', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(71, '2019-11-08', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(72, '2019-11-09', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(73, '2019-11-09', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(74, '2019-11-09', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(75, '2019-11-09', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(76, '2019-11-09', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(77, '2019-11-09', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(78, '2019-11-09', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(79, '2019-11-09', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(80, '2019-11-10', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(81, '2019-11-10', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(82, '2019-11-10', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(83, '2019-11-10', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(84, '2019-11-10', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(85, '2019-11-10', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(86, '2019-11-10', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(87, '2019-11-10', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(88, '2019-11-10', '16:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(89, '2019-11-10', '14:00:00', 2, 1, 1, '8 horas', 9, NULL, NULL),
(90, '2019-11-11', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(91, '2019-11-11', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(92, '2019-11-11', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(93, '2019-11-11', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(94, '2019-11-11', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(95, '2019-11-12', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(96, '2019-11-12', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(97, '2019-11-12', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(98, '2019-11-12', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(99, '2019-11-12', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(100, '2019-11-13', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(101, '2019-11-13', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(102, '2019-11-13', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(103, '2019-11-13', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(104, '2019-11-13', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(105, '2019-11-14', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(106, '2019-11-14', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(107, '2019-11-14', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(108, '2019-11-14', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(109, '2019-11-14', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(110, '2019-11-15', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(111, '2019-11-15', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(112, '2019-11-15', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(113, '2019-11-15', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(114, '2019-11-15', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(115, '2019-11-16', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(116, '2019-11-16', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(117, '2019-11-16', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(118, '2019-11-16', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(119, '2019-11-16', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(120, '2019-11-16', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(121, '2019-11-16', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(122, '2019-11-16', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(123, '2019-11-17', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(124, '2019-11-17', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(125, '2019-11-17', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(126, '2019-11-17', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(127, '2019-11-17', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(128, '2019-11-17', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(129, '2019-11-17', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(130, '2019-11-17', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(131, '2019-11-17', '16:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(132, '2019-11-17', '14:00:00', 2, 1, 1, '8 horas', 9, NULL, NULL),
(133, '2019-11-18', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(134, '2019-11-18', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(135, '2019-11-18', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(136, '2019-11-18', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(137, '2019-11-18', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(138, '2019-11-19', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(139, '2019-11-19', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(140, '2019-11-19', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(141, '2019-11-19', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(142, '2019-11-19', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(143, '2019-11-20', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(144, '2019-11-20', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(145, '2019-11-20', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(146, '2019-11-20', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(147, '2019-11-20', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(148, '2019-11-21', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(149, '2019-11-21', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(150, '2019-11-21', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(151, '2019-11-21', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(152, '2019-11-21', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(153, '2019-11-22', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(154, '2019-11-22', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(155, '2019-11-22', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(156, '2019-11-22', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(157, '2019-11-22', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(158, '2019-11-23', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(159, '2019-11-23', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(160, '2019-11-23', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(161, '2019-11-23', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(162, '2019-11-23', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(163, '2019-11-23', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(164, '2019-11-23', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(165, '2019-11-23', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(166, '2019-11-24', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(167, '2019-11-24', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(168, '2019-11-24', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(169, '2019-11-24', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(170, '2019-11-24', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(171, '2019-11-24', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(172, '2019-11-24', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(173, '2019-11-24', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(174, '2019-11-24', '16:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(175, '2019-11-24', '14:00:00', 2, 1, 1, '8 horas', 9, NULL, NULL),
(176, '2019-11-25', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(177, '2019-11-25', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(178, '2019-11-25', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(179, '2019-11-25', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(180, '2019-11-25', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(181, '2019-11-26', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(182, '2019-11-26', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(183, '2019-11-26', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(184, '2019-11-26', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(185, '2019-11-26', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(186, '2019-11-27', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(187, '2019-11-27', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(188, '2019-11-27', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(189, '2019-11-27', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(190, '2019-11-27', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(191, '2019-11-28', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(192, '2019-11-28', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(193, '2019-11-28', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(194, '2019-11-28', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(195, '2019-11-28', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(196, '2019-11-29', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(197, '2019-11-29', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(198, '2019-11-29', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(199, '2019-11-29', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(200, '2019-11-29', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(201, '2019-11-30', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(202, '2019-11-30', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(203, '2019-11-30', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(204, '2019-11-30', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(205, '2019-11-30', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(206, '2019-11-30', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(207, '2019-11-30', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(208, '2019-11-30', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(209, '2019-12-01', '07:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(210, '2019-12-01', '09:00:00', 2, 1, 1, '8 horas', 6, NULL, NULL),
(211, '2019-12-01', '11:00:00', 2, 2, 2, '8 horas', 2, NULL, NULL),
(212, '2019-12-01', '13:00:00', 2, 1, 1, '8 horas', 3, NULL, NULL),
(213, '2019-12-01', '16:00:00', 2, 1, 1, '8 horas', 7, NULL, NULL),
(214, '2019-12-01', '13:00:00', 2, 2, 2, '8 horas', 4, NULL, NULL),
(215, '2019-12-01', '07:00:00', 2, 1, 1, '8 horas', 5, NULL, NULL),
(216, '2019-12-01', '11:00:00', 2, 1, 1, '8 horas', 8, NULL, NULL),
(217, '2019-12-01', '16:00:00', 2, 2, 2, '8 horas', 1, NULL, NULL),
(218, '2019-12-01', '14:00:00', 2, 1, 1, '8 horas', 9, NULL, NULL),
(219, '2019-11-19', '10:00:00', 3, 1, 3, '4 horas', 10, NULL, NULL),
(220, '2019-11-19', '14:00:00', 3, 3, 4, '1 horas', 10, NULL, NULL),
(221, '2019-11-19', '15:00:00', 3, 4, 5, '16 horas', 10, NULL, 2),
(222, '2019-11-20', '07:00:00', 3, 5, 6, '26 horas', 10, NULL, 1),
(223, '2019-11-19', '16:00:00', 3, 1, 3, '4 horas', 22, NULL, NULL),
(224, '2019-11-19', '20:00:00', 3, 3, 4, '1 horas', 22, NULL, NULL),
(225, '2019-11-19', '21:00:00', 3, 4, 5, '16 horas', 22, NULL, NULL),
(226, '2019-11-20', '13:00:00', 3, 5, 6, '26 horas', 22, NULL, NULL),
(227, '2019-11-19', '10:00:00', 3, 6, 5, '26 horas', 12, NULL, NULL),
(228, '2019-11-20', '12:00:00', 3, 5, 4, '16 horas', 12, NULL, NULL),
(229, '2019-11-21', '04:00:00', 3, 4, 3, '1 horas', 12, NULL, NULL),
(230, '2019-11-21', '05:00:00', 3, 3, 1, '4 horas', 12, NULL, NULL),
(231, '2019-11-19', '16:00:00', 3, 6, 5, '26 horas', 23, NULL, NULL),
(232, '2019-11-20', '18:00:00', 3, 5, 4, '16 horas', 23, NULL, NULL),
(233, '2019-11-21', '10:00:00', 3, 4, 3, '1 horas', 23, NULL, NULL),
(234, '2019-11-21', '11:00:00', 3, 3, 1, '4 horas', 23, NULL, NULL),
(235, '2019-11-20', '10:00:00', 3, 1, 3, '3 horas', 27, NULL, NULL),
(236, '2019-11-20', '13:00:00', 3, 3, 4, '1 horas', 27, NULL, NULL),
(237, '2019-11-20', '14:00:00', 3, 4, 5, '9 horas', 27, NULL, NULL),
(238, '2019-11-20', '23:00:00', 3, 5, 6, '22 horas', 27, NULL, NULL),
(239, '2019-11-20', '16:00:00', 3, 1, 3, '3 horas', 28, NULL, NULL),
(240, '2019-11-20', '19:00:00', 3, 3, 4, '1 horas', 28, NULL, NULL),
(241, '2019-11-20', '20:00:00', 3, 4, 5, '9 horas', 28, NULL, NULL),
(242, '2019-11-21', '05:00:00', 3, 5, 6, '22 horas', 28, NULL, NULL),
(243, '2019-11-20', '10:00:00', 3, 6, 5, '22 horas', 29, NULL, NULL),
(244, '2019-11-21', '08:00:00', 3, 5, 4, '9 horas', 29, NULL, NULL),
(245, '2019-11-21', '17:00:00', 3, 4, 3, '1 horas', 29, NULL, NULL),
(246, '2019-11-21', '18:00:00', 3, 3, 1, '3 horas', 29, NULL, NULL),
(247, '2019-11-20', '16:00:00', 3, 6, 5, '22 horas', 35, NULL, NULL),
(248, '2019-11-20', '14:00:00', 3, 5, 4, '9 horas', 35, NULL, NULL),
(249, '2019-11-20', '23:00:00', 3, 4, 3, '1 horas', 35, NULL, NULL),
(250, '2019-11-21', '00:00:00', 3, 3, 1, '3 horas', 35, NULL, NULL),
(251, '2019-11-19', '10:00:00', 3, 2, 3, '4 horas', 13, NULL, NULL),
(252, '2019-11-19', '14:00:00', 3, 3, 4, '1 horas', 13, NULL, NULL),
(253, '2019-11-19', '15:00:00', 3, 4, 5, '16 horas', 13, NULL, NULL),
(254, '2019-11-20', '07:00:00', 3, 5, 6, '26 horas', 13, NULL, NULL),
(255, '2019-11-19', '16:00:00', 3, 2, 3, '4 horas', 18, NULL, NULL),
(256, '2019-11-19', '20:00:00', 3, 3, 4, '1 horas', 18, NULL, NULL),
(257, '2019-11-19', '21:00:00', 3, 4, 5, '16 horas', 18, NULL, NULL),
(258, '2019-11-20', '13:00:00', 3, 5, 6, '26 horas', 18, NULL, NULL),
(259, '2019-11-19', '10:00:00', 3, 6, 5, '26 horas', 17, NULL, NULL),
(260, '2019-11-20', '12:00:00', 3, 5, 4, '16 horas', 17, NULL, NULL),
(261, '2019-11-21', '04:00:00', 3, 4, 3, '1 horas', 17, NULL, NULL),
(262, '2019-11-21', '05:00:00', 3, 3, 2, '4 horas', 17, NULL, NULL),
(263, '2019-11-19', '16:00:00', 3, 6, 5, '26 horas', 19, NULL, NULL),
(264, '2019-11-20', '18:00:00', 3, 5, 4, '16 horas', 19, NULL, NULL),
(265, '2019-11-21', '10:00:00', 3, 4, 3, '1 horas', 19, NULL, NULL),
(266, '2019-11-21', '11:00:00', 3, 3, 2, '4 horas', 19, NULL, NULL),
(267, '2019-11-20', '10:00:00', 3, 2, 3, '3 horas', 36, NULL, NULL),
(268, '2019-11-20', '13:00:00', 3, 3, 4, '1 horas', 36, NULL, NULL),
(269, '2019-11-20', '14:00:00', 3, 4, 5, '9 horas', 36, NULL, NULL),
(270, '2019-11-20', '23:00:00', 3, 5, 6, '22 horas', 36, NULL, NULL),
(271, '2019-11-20', '16:00:00', 3, 2, 3, '3 horas', 37, NULL, NULL),
(272, '2019-11-20', '19:00:00', 3, 3, 4, '1 horas', 37, NULL, NULL),
(273, '2019-11-20', '20:00:00', 3, 4, 5, '9 horas', 37, NULL, NULL),
(274, '2019-11-21', '05:00:00', 3, 5, 6, '22 horas', 37, NULL, NULL),
(275, '2019-11-20', '10:00:00', 3, 6, 5, '22 horas', 43, NULL, NULL),
(276, '2019-11-21', '08:00:00', 3, 5, 4, '9 horas', 43, NULL, NULL),
(277, '2019-11-21', '17:00:00', 3, 4, 3, '1 horas', 43, NULL, NULL),
(278, '2019-11-21', '18:00:00', 3, 3, 2, '3 horas', 43, NULL, NULL),
(279, '2019-11-20', '16:00:00', 3, 6, 5, '22 horas', 44, NULL, NULL),
(280, '2019-11-20', '14:00:00', 3, 5, 4, '9 horas', 44, NULL, NULL),
(281, '2019-11-20', '23:00:00', 3, 4, 3, '1 horas', 44, NULL, NULL),
(282, '2019-11-21', '00:00:00', 3, 3, 2, '3 horas', 44, NULL, NULL),
(283, '2019-11-19', '10:00:00', 3, 1, 3, '4 horas', 11, NULL, NULL),
(284, '2019-11-19', '14:00:00', 3, 3, 5, '14 horas', 11, NULL, NULL),
(285, '2019-11-20', '04:00:00', 3, 5, 7, '48 horas', 11, NULL, NULL),
(286, '2019-11-22', '04:00:00', 3, 7, 8, '50 horas', 11, NULL, NULL),
(287, '2019-11-24', '06:00:00', 3, 8, 9, '51 horas', 11, NULL, NULL),
(288, '2019-11-26', '09:00:00', 3, 9, 10, '70 horas', 11, NULL, NULL),
(289, '2019-11-29', '07:00:00', 3, 10, 11, '77 horas', 11, NULL, NULL),
(290, '2019-11-19', '16:00:00', 3, 1, 3, '4 horas', 14, NULL, NULL),
(291, '2019-11-19', '20:00:00', 3, 3, 5, '14 horas', 14, NULL, NULL),
(292, '2019-11-20', '10:00:00', 3, 5, 7, '48 horas', 14, NULL, NULL),
(293, '2019-11-22', '10:00:00', 3, 7, 8, '50 horas', 14, NULL, NULL),
(294, '2019-11-24', '12:00:00', 3, 8, 9, '51 horas', 14, NULL, NULL),
(295, '2019-11-26', '15:00:00', 3, 9, 10, '70 horas', 14, NULL, NULL),
(296, '2019-11-29', '13:00:00', 3, 10, 11, '77 horas', 14, NULL, NULL),
(297, '2019-11-19', '10:00:00', 3, 11, 10, '77 horas', 15, NULL, NULL),
(298, '2019-11-22', '15:00:00', 3, 10, 9, '70 horas', 15, NULL, NULL),
(299, '2019-11-25', '13:00:00', 3, 9, 8, '51 horas', 15, NULL, NULL),
(300, '2019-11-27', '16:00:00', 3, 8, 7, '50 horas', 15, NULL, NULL),
(301, '2019-11-29', '18:00:00', 3, 7, 5, '48 horas', 15, NULL, NULL),
(302, '2019-12-01', '18:00:00', 3, 5, 3, '14 horas', 15, NULL, NULL),
(303, '2019-12-02', '08:00:00', 3, 3, 1, '4 horas', 15, NULL, NULL),
(304, '2019-11-19', '16:00:00', 3, 11, 10, '77 horas', 16, NULL, NULL),
(305, '2019-11-22', '21:00:00', 3, 10, 9, '70 horas', 16, NULL, NULL),
(306, '2019-11-25', '19:00:00', 3, 9, 8, '51 horas', 16, NULL, NULL),
(307, '2019-11-27', '22:00:00', 3, 8, 7, '50 horas', 16, NULL, NULL),
(308, '2019-11-29', '00:00:00', 3, 7, 5, '48 horas', 16, NULL, NULL),
(309, '2019-12-01', '00:00:00', 3, 5, 3, '14 horas', 16, NULL, NULL),
(310, '2019-12-01', '14:00:00', 3, 3, 1, '4 horas', 16, NULL, NULL),
(311, '2019-11-19', '10:00:00', 3, 2, 3, '4 horas', 31, NULL, NULL),
(312, '2019-11-19', '14:00:00', 3, 3, 5, '14 horas', 31, NULL, NULL),
(313, '2019-11-20', '04:00:00', 3, 5, 7, '48 horas', 31, NULL, NULL),
(314, '2019-11-22', '04:00:00', 3, 7, 8, '50 horas', 31, NULL, NULL),
(315, '2019-11-24', '06:00:00', 3, 8, 9, '51 horas', 31, NULL, NULL),
(316, '2019-11-26', '09:00:00', 3, 9, 10, '70 horas', 31, NULL, NULL),
(317, '2019-11-29', '07:00:00', 3, 10, 11, '77 horas', 31, NULL, NULL),
(318, '2019-11-19', '16:00:00', 3, 2, 3, '4 horas', 32, NULL, NULL),
(319, '2019-11-19', '20:00:00', 3, 3, 5, '14 horas', 32, NULL, NULL),
(320, '2019-11-20', '10:00:00', 3, 5, 7, '48 horas', 32, NULL, NULL),
(321, '2019-11-22', '10:00:00', 3, 7, 8, '50 horas', 32, NULL, NULL),
(322, '2019-11-24', '12:00:00', 3, 8, 9, '51 horas', 32, NULL, NULL),
(323, '2019-11-26', '15:00:00', 3, 9, 10, '70 horas', 32, NULL, NULL),
(324, '2019-11-29', '13:00:00', 3, 10, 11, '77 horas', 32, NULL, NULL),
(325, '2019-11-19', '10:00:00', 3, 11, 10, '77 horas', 33, NULL, NULL),
(326, '2019-11-22', '15:00:00', 3, 10, 9, '70 horas', 33, NULL, NULL),
(327, '2019-11-25', '13:00:00', 3, 9, 8, '51 horas', 33, NULL, NULL),
(328, '2019-11-27', '16:00:00', 3, 8, 7, '50 horas', 33, NULL, NULL),
(329, '2019-11-29', '18:00:00', 3, 7, 5, '48 horas', 33, NULL, NULL),
(330, '2019-12-01', '18:00:00', 3, 5, 3, '14 horas', 33, NULL, NULL),
(331, '2019-12-02', '08:00:00', 3, 3, 2, '4 horas', 33, NULL, NULL),
(332, '2019-11-19', '16:00:00', 3, 11, 10, '77 horas', 39, NULL, NULL),
(333, '2019-11-22', '21:00:00', 3, 10, 9, '70 horas', 39, NULL, NULL),
(334, '2019-11-25', '19:00:00', 3, 9, 8, '51 horas', 39, NULL, NULL),
(335, '2019-11-27', '22:00:00', 3, 8, 7, '50 horas', 39, NULL, NULL),
(336, '2019-11-29', '00:00:00', 3, 7, 5, '48 horas', 39, NULL, NULL),
(337, '2019-12-01', '00:00:00', 3, 5, 3, '14 horas', 39, NULL, NULL),
(338, '2019-12-01', '14:00:00', 3, 3, 2, '4 horas', 39, NULL, NULL);

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `centro_medico` (`centro_medico`);

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
  ADD KEY `nave` (`nave`),
  ADD KEY `circuitos` (`circuitos`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `centros_medicos`
--
ALTER TABLE `centros_medicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `circuitos`
--
ALTER TABLE `circuitos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `turnos_ibfk_2` FOREIGN KEY (`centro_medico`) REFERENCES `centros_medicos` (`id`);

--
-- Filtros para la tabla `viajes_t`
--
ALTER TABLE `viajes_t`
  ADD CONSTRAINT `viajes_t_ibfk_1` FOREIGN KEY (`tipo_viaje`) REFERENCES `tipo_viajes` (`id`),
  ADD CONSTRAINT `viajes_t_ibfk_2` FOREIGN KEY (`origen`) REFERENCES `estaciones` (`id`),
  ADD CONSTRAINT `viajes_t_ibfk_3` FOREIGN KEY (`destino`) REFERENCES `estaciones` (`id`),
  ADD CONSTRAINT `viajes_t_ibfk_4` FOREIGN KEY (`nave`) REFERENCES `naves` (`id`),
  ADD CONSTRAINT `viajes_t_ibfk_5` FOREIGN KEY (`circuitos`) REFERENCES `circuitos` (`id`);
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Volcado de datos para la tabla `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"angular_direct\":\"direct\",\"snap_to_grid\":\"off\",\"relation_lines\":\"true\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Volcado de datos para la tabla `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'database', 'gauchorocket', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"structure_or_data_forced\":\"0\",\"table_select[]\":[\"circuitos\",\"circutios_estaciones\",\"estaciones\",\"modelos_naves\",\"naves\",\"reservas\",\"roles\",\"tipo_viajes\",\"usuarios\",\"viajes\",\"viajes_t\"],\"table_structure[]\":[\"circuitos\",\"circutios_estaciones\",\"estaciones\",\"modelos_naves\",\"naves\",\"reservas\",\"roles\",\"tipo_viajes\",\"usuarios\",\"viajes\",\"viajes_t\"],\"table_data[]\":[\"circuitos\",\"circutios_estaciones\",\"estaciones\",\"modelos_naves\",\"naves\",\"reservas\",\"roles\",\"tipo_viajes\",\"usuarios\",\"viajes\",\"viajes_t\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@DATABASE@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Estructura de la tabla @TABLE@\",\"latex_structure_continued_caption\":\"Estructura de la tabla @TABLE@ (continÃºa)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Contenido de la tabla @TABLE@\",\"latex_data_continued_caption\":\"Contenido de la tabla @TABLE@ (continÃºa)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"structure_and_data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"structure_and_data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_procedure_function\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"xml_structure_or_data\":\"data\",\"xml_export_events\":\"something\",\"xml_export_functions\":\"something\",\"xml_export_procedures\":\"something\",\"xml_export_tables\":\"something\",\"xml_export_triggers\":\"something\",\"xml_export_views\":\"something\",\"xml_export_contents\":\"something\",\"yaml_structure_or_data\":\"data\",\"\":null,\"lock_tables\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_create_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}'),
(2, 'root', 'server', 'gauchorocket', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"elbrote\",\"gauchorocket\",\"phpmyadmin\",\"pokemons-dominikow-sebastian\",\"pokemons_bd\",\"pw\",\"test\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Estructura de la tabla @TABLE@\",\"latex_structure_continued_caption\":\"Estructura de la tabla @TABLE@ (continÃºa)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Contenido de la tabla @TABLE@\",\"latex_data_continued_caption\":\"Contenido de la tabla @TABLE@ (continÃºa)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"gauchorocket\",\"table\":\"estaciones\"},{\"db\":\"gauchorocket\",\"table\":\"circuitos\"},{\"db\":\"gauchorocket\",\"table\":\"viajes\"},{\"db\":\"gauchorocket\",\"table\":\"tipo_viajes\"},{\"db\":\"gauchorocket\",\"table\":\"dias\"},{\"db\":\"pokemons-dominikow-sebastian\",\"table\":\"pokemon\"},{\"db\":\"a11a1a1a1\",\"table\":\"pokemon\"},{\"db\":\"a11a1a1a1\",\"table\":\"usuario\"},{\"db\":\"pokemons-seijas-tomas\",\"table\":\"pokemon\"},{\"db\":\"pokemons-seijas-tomas\",\"table\":\"tipopokemon\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2019-11-05 01:56:46', '{\"lang\":\"es\",\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `pokemons-dominikow-sebastian`
--
CREATE DATABASE IF NOT EXISTS `pokemons-dominikow-sebastian` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pokemons-dominikow-sebastian`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pokemon`
--

CREATE TABLE `pokemon` (
  `id` int(11) NOT NULL,
  `imagen` varchar(100) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `numero` int(3) NOT NULL,
  `tipo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pokemon`
--

INSERT INTO `pokemon` (`id`, `imagen`, `nombre`, `numero`, `tipo`) VALUES
(1, 'img/Bulbasaur.png', 'Bulbasaur', 1, 'Planta'),
(2, 'img/Ivysaur.png', 'Ivysaur', 2, 'Planta'),
(3, 'img/Venusaur.png', 'Venusaur', 3, 'Planta'),
(4, 'img/Charmander.png', 'Charmander', 4, 'Fuego'),
(5, 'img/Charmeleon.png', 'Charmeleon', 5, 'Fuego'),
(6, 'img/Charizard.png', 'Charizard', 6, 'Fuego'),
(7, 'img/Squirtle.png', 'Squirtle', 7, 'Agua'),
(8, 'img/Wartortle.png', 'Wartortle', 8, 'Agua'),
(9, 'img/Blastoise.png', 'Blastoise', 9, 'Agua'),
(10, 'img/Caterpie.png', 'Caterpie', 10, 'Insecto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombreUsuario` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombreUsuario`, `password`) VALUES
(1, 'admin', 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pokemon`
--
ALTER TABLE `pokemon`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pokemon`
--
ALTER TABLE `pokemon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Base de datos: `pokemons_bd`
--
CREATE DATABASE IF NOT EXISTS `pokemons_bd` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pokemons_bd`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `user` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`user`, `password`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pokemon`
--

CREATE TABLE `pokemon` (
  `id` int(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(1000) NOT NULL,
  `foto` varchar(1000) NOT NULL,
  `descripcion` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pokemon`
--

INSERT INTO `pokemon` (`id`, `nombre`, `tipo`, `foto`, `descripcion`) VALUES
(1, 'Bulbasur', 'https://pm1.narvii.com/6368/e108d8f91bd4f1dc74ef147779eabaf783b66163_hq.jpg', 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/001.png', NULL),
(2, 'Ivysaur', 'https://pm1.narvii.com/6368/e108d8f91bd4f1dc74ef147779eabaf783b66163_hq.jpg', 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/002.png', NULL),
(3, 'Venusaur', 'https://pm1.narvii.com/6368/e108d8f91bd4f1dc74ef147779eabaf783b66163_hq.jpg', 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/003.png', NULL),
(4, 'Charmander', 'https://pm1.narvii.com/6712/a5a401797e0d625d7548d309752d746fb65aecdf_hq.jpg', 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/004.png', NULL),
(5, 'Charmeleon', 'https://pm1.narvii.com/6712/a5a401797e0d625d7548d309752d746fb65aecdf_hq.jpg', 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/005.png', NULL),
(6, 'Charizard', 'https://pm1.narvii.com/6712/a5a401797e0d625d7548d309752d746fb65aecdf_hq.jpg', 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/006.png', NULL),
(25, 'Pikachu', 'https://i.pinimg.com/originals/e5/c1/2b/e5c12bd2552d60f6d625683282b17aa4.png', 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/025.png', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pokemon`
--
ALTER TABLE `pokemon`
  ADD PRIMARY KEY (`id`);
--
-- Base de datos: `pw`
--
CREATE DATABASE IF NOT EXISTS `pw` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pw`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `nombreUsuario` varchar(100) NOT NULL,
  `claveUsuario` varchar(100) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `cuit` varchar(14) NOT NULL,
  `telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombreUsuario`, `claveUsuario`, `nombre`, `apellido`, `email`, `direccion`, `cuit`, `telefono`) VALUES
(1, 'ale', '926E27EECDBC7A18858B3798BA99BDDD', '', '', '', '', '', ''),
(2, 'seba', 'a9d489591e78210fbd5190249af8725e', '', '', '', '', '', ''),
(3, 'Sebakow', '7ef852449f736f512f020cc4edc978f0', 'Sebastian', 'Dominikow', 'sebidomi@hotmail.com', 'av de mayo 1222', '20-40671857-4', '1140704060');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
