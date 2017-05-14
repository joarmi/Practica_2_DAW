-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-05-2017 a las 14:51:31
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mr_javiondo_gamer`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE `administradores` (
  `id_administrador` int(10) NOT NULL,
  `admin` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(20) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='tabla de administradores';

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`id_administrador`, `admin`, `password`) VALUES
(1, 'javi', '12345'),
(2, 'santi', '12345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(10) NOT NULL,
  `nombre_usuario` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `nombre_producto` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `precio` float NOT NULL,
  `cantidad` int(10) NOT NULL,
  `envio` tinyint(1) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='tabla de pedidos';

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `nombre_usuario`, `nombre_producto`, `precio`, `cantidad`, `envio`, `fecha`) VALUES
(1, 'joarmi', 'Horizon: Zero Dawn (PS4)', 70, 2, 0, '2017-05-03'),
(2, 'joarmi', 'Nier:Automata (PS4)', 65, 2, 0, '2017-05-01'),
(3, 'casbel', 'Devil May Cry HD Collections (PS3)', 35, 2, 0, '2017-05-01'),
(7, 'lluchpa', 'Horizon: Zero Dawn (PS4)', 70, 1, 0, '2017-05-01'),
(8, 'lluchpa', 'Nier:Automata (PS4)', 65, 2, 0, '2017-05-01'),
(11, 'joarmi', 'FIFA 17 (PS4)', 20, 2, 0, '2017-05-01'),
(14, 'joarmi', 'Assassins Creed The Ezio Collection (PS4)', 40, 1, 1, '2017-05-01'),
(15, 'hola', 'Horizon: Zero Dawn (PS4)', 70, 2, 1, '2017-05-01'),
(16, 'hola', 'Persona 5 (PS4)', 69.95, 2, 1, '2017-05-01'),
(17, 'hola', 'Halo 5 Guardians (Xbox One)', 59.95, 1, 0, '2017-05-01'),
(19, 'joarmi', 'Rainbow Six Siege (PS4)', 20, 2, 1, '2017-05-13'),
(20, 'joarmi', 'Watch Dogs 2 (PS4)', 45.95, 1, 1, '2017-05-13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(20) NOT NULL,
  `descripcion` varchar(800) COLLATE utf8_spanish_ci NOT NULL,
  `precio` float NOT NULL,
  `nombre_producto` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `stock` int(100) NOT NULL,
  `alta` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `descripcion`, `precio`, `nombre_producto`, `stock`, `alta`) VALUES
(1, 'Futurista y divertido, con un toque clï¿½sico, de lo mejor, de lo mejor.        ', 65, 'Horizon: Zero Dawn (PS4)', 10, 0),
(2, ' Robots y peleas. ', 65, 'Nier:Automata (PS4)', 5, 0),
(3, 'El mejor juego del mundo.', 35, 'Devil May Cry HD Collections (PS3)', 5, 0),
(4, 'Futbol, asi de simple.', 20, 'FIFA 17 (PS4)', 2, 0),
(5, 'Espacial, trepidante y muy entretenido.', 35, 'Ratchet & Clank (PS4)', 10, 0),
(6, 'Uno de los mejores juegos de la historia de los videojuegos.', 19.95, 'Jack & Daxter (PS3)', 10, 0),
(7, 'Los mejores juegos de Assassins Creed en un solo pack.', 40, 'Assassins Creed The Ezio Collection (PS4)', 7, 0),
(8, 'El mejor del año, asi de fácil.', 35.5, 'Grand Theft Auto V (PS4)', 7, 0),
(9, 'Un juego psicodeligo y muy entretenido, perteneciente al género JRPG.', 69.95, 'Persona 5 (PS4)', 13, 0),
(10, 'Asalto, terrorismo, quien ganará?. Con este trepidante shooter lo descubriras, encargando a uno de ambos bandos con tus amigos.', 20, 'Rainbow Six Siege (PS4)', 7, 0),
(11, 'Juego intrigante del género de los puzzles, pero con una historia sorprendente y muy interesante.', 15.95, 'Portal 2 (PS3)', 20, 0),
(12, 'Hackear nunca había sido tan divertido, con esta nueva entrega de Watch Dogs.', 45.95, 'Watch Dogs 2 (PS4)', 14, 0),
(13, 'Fantasía, sobrenatural, la última entrega de The Witcher con una gran historia y jugabilidad.', 50, 'The Witcher 3 GOTY Edition (PS4)', 10, 0),
(14, 'Nunca ha sido tan divertido asesinar dioses, con la esperada remasterización de la tercera entrega de God of War.', 30, 'God of War Remastered (PS4)', 10, 0),
(15, 'Defenderse de una invasión extraterrestre destruyéndolos con una motosierra, eso y mucho más en esta nueva entrega de Gears of War', 69.95, 'Gears of War 4 Ultimate Edition (Xbox One)', 10, 0),
(16, 'Nos meteremos en la piel de uno de los soldados de élite de la primera guerra mundial para masacrar a nuestros enemigos.', 54.95, 'Battlefield 1 (PS4)', 10, 0),
(17, 'Siguiente entrega de la maravillosa saga de Halo', 59.95, 'Halo 5 Guardians (Xbox One)', 9, 0),
(18, 'Siguiente y última entre del gran caballero oscuro.', 59.95, 'Batman Arkham Knight (PS4)', 10, 0),
(19, 'Diviertete con tus amigos cantando los mejores éxitos musicales de los último 20 años.', 45.95, 'Singstar Ultimate Party (PS4)', 10, 0),
(20, 'Una de las mejores sagas de videojuegos de todos los tiempos.', 19.95, 'Uncharted The Nathan Drake Collection (PS4)', 10, 0),
(21, ' Lo mejor del mundo.', 59.95, 'Uncharted 4 A Thiefs End (PS4)', 8, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sugerencias`
--

CREATE TABLE `sugerencias` (
  `id_sugerencia` int(10) NOT NULL,
  `sugerencia` varchar(800) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `sugerencias`
--

INSERT INTO `sugerencias` (`id_sugerencia`, `sugerencia`, `email`) VALUES
(1, ' Esta tienda mola mucho.', 'javi@gmail.com'),
(2, ' Esta tienda es la mejor.', 'jose@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(10) NOT NULL,
  `usuario` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `contrasenya` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla de usuarios';

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `usuario`, `contrasenya`, `nombre`, `apellidos`, `telefono`, `direccion`, `email`) VALUES
(1, 'joarmi', '1234', 'Javier', 'Argente', '123456788', 'Universidad de Valencia', 'joarmi_95@alumni.uv.es'),
(2, 'casbel', '1234', 'Santiago', 'Castello Beltran', '987654321', 'Mi casa', 'casbel2@alumni.uv.es'),
(3, 'lluchpa', '1234', 'Jose', 'LLuch Palop', '123456789', 'calle se', 'jose@gmail.com'),
(4, 'hola', '1234', 'j', 'j', '123456789', 'hola', 'hola@hola');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`id_administrador`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `sugerencias`
--
ALTER TABLE `sugerencias`
  ADD PRIMARY KEY (`id_sugerencia`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administradores`
--
ALTER TABLE `administradores`
  MODIFY `id_administrador` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT de la tabla `sugerencias`
--
ALTER TABLE `sugerencias`
  MODIFY `id_sugerencia` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
