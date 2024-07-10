-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 12-04-2024 a las 15:47:25
-- Versión del servidor: 10.6.17-MariaDB-cll-lve
-- Versión de PHP: 8.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `xfylwmxa_barber`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberia`
--

CREATE TABLE `barberia` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `direccion` text NOT NULL,
  `ciudad` text NOT NULL,
  `logo` text NOT NULL,
  `fecha_registro` text NOT NULL,
  `fecha_renovacion` text NOT NULL,
  `propietario` text NOT NULL,
  `usuario` text NOT NULL,
  `password` text NOT NULL,
  `horario` text NOT NULL,
  `telefono` text NOT NULL,
  `calificacion` double DEFAULT 0,
  `numero_calificaciones` int(11) DEFAULT 0,
  `Lat` text NOT NULL,
  `Lng` text NOT NULL,
  `horarioa` varchar(45) DEFAULT NULL,
  `horarioc` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `barberia`
--

INSERT INTO `barberia` (`id`, `nombre`, `direccion`, `ciudad`, `logo`, `fecha_registro`, `fecha_renovacion`, `propietario`, `usuario`, `password`, `horario`, `telefono`, `calificacion`, `numero_calificaciones`, `Lat`, `Lng`, `horarioa`, `horarioc`) VALUES
(5, 'BarberShop', 'MZ 1 CASA 7/13 NUEVO MILENIO - VALLEDUPAR', 'valledupar', 'descarga (2).jfif', '2021-11-03', '2021-12-03', 'fabian', 'root@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '6AM - 10PM', '3042065930', 3.5, 4, '10.481191281442538', '-73.26957948364534', '08:00', '21:00'),
(6, 'BarberShop Fab', 'MZ 1 CASA 7/13 NUEVO MILENIO - VALLEDUPAR', 'valledupar', 'descarga (1).jfif', '2021-11-04', '2021-12-04', 'fabian', 'grovveip@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '6AM - 10PM', '3042065930', 0, 0, '10.463870690241059', '-73.28042942686369', '08:00', '22:00'),
(7, 'CAVALIERS', 'Mz 1 casa 7/13 Nuevo milenio - valledupar', 'valledupar', 'descarga.jfif', '2021-11-05', '2021-12-05', 'fabian', 'fandresquintero@unicesar.edu.co', '13866700f2a42af7393471ed1f056837', '6AM - 10PM', '3042065930', 0, 0, '10.459017463091845', '-73.26712567013328', '08:00', '20:30'),
(8, 'Barber Fabian', 'manzana 2 casa 8', 'valledupar', '2d73dbf861e7416144cbd69a6f8e69fb.jpg', '2021-11-03', '2021-12-03', 'fabian', 'root@gmail.com', 'c34c3126c045e327754fa22abc4872fc', '6AM - 10PM', '3042065930', 0, 0, '10.441284169255736', '-73.25819005747906', '09:00', '19:00'),
(9, 'CAVALIERS 2', 'manzana 2 casa 8', 'valledupar', 'images.jfif', '2021-11-04', '2021-12-04', 'fabian', 'root@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '9AM - 9PM', '4534534345', 0, 0, '10.449783286866408', '-73.23218421470091', '07:00', '20:00'),
(10, 'barber FQM', 'manzana 2 casa 8, urbanizacion ciudad tayrona', 'valledupar', 'logo.png', '2023-04-14', '2023-05-14', 'fabian Q', '@fabian', '6bf8190615e9e50307b09cbbf12eb3b4', '07:42-22:00', '3088938902', 0, 0, '10.477477721919268', '-73.25340039971353', '06:00', '22:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `barberia`
--
ALTER TABLE `barberia`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `barberia`
--
ALTER TABLE `barberia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
