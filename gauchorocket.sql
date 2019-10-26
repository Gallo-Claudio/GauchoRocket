CREATE DATABASE gauchorocket;
USE gauchorocket;

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
-- Estructura de tabla para la tabla `circutios_estaciones`
--

CREATE TABLE `circutios_estaciones` (
  `circuito_id` int(11) NOT NULL,
  `estacion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `circutios_estaciones`
--

INSERT INTO `circutios_estaciones` (`circuito_id`, `estacion_id`) VALUES
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
  `usuario` varchar(30) NOT NULL,
  `clave` varchar(15) NOT NULL,
  `rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `clave`, `rol`) VALUES
(1, 'Tomas', '1234', 1),
(2, 'Sebastian', '1234', 2),
(4, 'facu', 'facu', 2),
(5, 'Julieta', '1234', 2);
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
  `circuito_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `viajes`
--

INSERT INTO `viajes` (`id`, `tipo_viaje`, `duracion`, `fecha_salida`, `hora_salida`, `circuito_id`) VALUES
(1, 1, '35 dias', '2019-10-27', '16:00:00', NULL),
(2, 2, '8 horas', '2019-10-27', '03:00:00', NULL),
(3, 2, '8 horas', '2019-10-27', '22:00:00', NULL),
(4, 2, '8 horas', '2019-10-27', '15:00:00', NULL),
(5, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(6, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(7, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(8, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(9, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(10, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(11, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(12, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(13, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(14, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(15, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(16, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(17, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(18, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(19, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(20, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(21, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(22, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(23, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(24, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(25, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(26, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(27, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(28, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(29, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(30, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(31, 2, '8 horas', '2019-10-23', '17:30:00', NULL),
(32, 2, '8 horas', '2019-10-23', '02:00:00', NULL),
(33, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(34, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(35, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(36, 2, '8 horas', '0000-00-00', '00:00:00', NULL),
(37, 3, NULL, '0000-00-00', '00:00:00', 1),
(38, 3, NULL, '2019-10-23', '23:30:00', 2),
(39, 3, NULL, '0000-00-00', '00:00:00', 2),
(40, 3, NULL, '0000-00-00', '00:00:00', 1),
(41, 3, NULL, '0000-00-00', '00:00:00', 2),
(42, 3, NULL, '0000-00-00', '00:00:00', 1),
(43, 3, NULL, '0000-00-00', '00:00:00', 2),
(44, 3, NULL, '0000-00-00', '00:00:00', 1),
(45, 3, NULL, '0000-00-00', '00:00:00', 1),
(46, 3, NULL, '0000-00-00', '00:00:00', 2),
(47, 3, NULL, '0000-00-00', '00:00:00', 1),
(48, 3, NULL, '0000-00-00', '00:00:00', 2),
(49, 3, NULL, '0000-00-00', '00:00:00', 1),
(50, 3, NULL, '2019-10-23', '22:00:00', 2),
(51, 3, NULL, '0000-00-00', '00:00:00', 1),
(52, 3, NULL, '0000-00-00', '00:00:00', 1),
(53, 3, NULL, '0000-00-00', '00:00:00', 2),
(54, 3, NULL, '2019-10-23', '20:00:00', 2),
(55, 3, NULL, '0000-00-00', '00:00:00', 1),
(56, 3, NULL, '0000-00-00', '00:00:00', 1),
(57, 3, NULL, '2019-10-23', '12:45:00', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `circuitos`
--
ALTER TABLE `circuitos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `circutios_estaciones`
--
ALTER TABLE `circutios_estaciones`
  ADD PRIMARY KEY (`circuito_id`,`estacion_id`),
  ADD KEY `estacion_id` (`estacion_id`);

--
-- Indices de la tabla `estaciones`
--
ALTER TABLE `estaciones`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol` (`rol`);

--
-- Indices de la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_viaje` (`tipo_viaje`),
  ADD KEY `circuito_id` (`circuito_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `circuitos`
--
ALTER TABLE `circuitos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estaciones`
--
ALTER TABLE `estaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `viajes`
--
ALTER TABLE `viajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `circutios_estaciones`
--
ALTER TABLE `circutios_estaciones`
  ADD CONSTRAINT `circutios_estaciones_ibfk_1` FOREIGN KEY (`circuito_id`) REFERENCES `circuitos` (`id`),
  ADD CONSTRAINT `circutios_estaciones_ibfk_2` FOREIGN KEY (`estacion_id`) REFERENCES `estaciones` (`id`);

--
-- Filtros para la tabla `usuario_reserva`
--
ALTER TABLE `usuario_reserva`
  ADD CONSTRAINT `usuario_reserva_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `usuario_reserva_ibfk_2` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD CONSTRAINT `viajes_ibfk_1` FOREIGN KEY (`tipo_viaje`) REFERENCES `tipo_viajes` (`id`),
  ADD CONSTRAINT `viajes_ibfk_2` FOREIGN KEY (`circuito_id`) REFERENCES `circuitos` (`id`);