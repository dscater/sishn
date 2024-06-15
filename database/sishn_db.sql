-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 15-06-2024 a las 15:31:47
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sishn_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `biometricos`
--

CREATE TABLE `biometricos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marca` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `garantia` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_hdn` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manual_usuario` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manual_servicio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unidad_area_id` bigint UNSIGNED DEFAULT NULL,
  `empresa_id` bigint UNSIGNED DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accesorios` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_equipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `biometricos`
--

INSERT INTO `biometricos` (`id`, `nombre`, `estado`, `marca`, `serie`, `modelo`, `fecha_ingreso`, `garantia`, `cod_hdn`, `manual_usuario`, `manual_servicio`, `unidad_area_id`, `empresa_id`, `foto`, `accesorios`, `estado_equipo`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'EQUIPO #1', 'REGULAR', 'M0001', 'S-001', 'M-001', '2024-01-01', 'SI', 'HDN-001', '1712417405_11.pdf', '1712417417_21.pdf', 1, 1, '1707238084_1.png', '', 'ACTIVO', '2024-02-06', 1, '2024-02-06 16:48:04', '2024-05-02 16:58:54'),
(2, 'EQUIPO #2', 'BUENO', '', '', '', '2024-02-08', 'NO', 'COD-002', NULL, NULL, 2, NULL, NULL, '', 'INACTIVO', '2024-02-08', 1, '2024-02-08 15:26:52', '2024-05-02 16:58:50'),
(3, 'EQUIPO #3', 'REGULAR', 'MARCA-002', 'SER-003', 'MOD-003', '2024-02-08', 'SI', 'COD-0002', NULL, NULL, 2, 3, NULL, '', 'ACTIVO', '2024-02-08', 1, '2024-02-09 00:20:37', '2024-05-02 16:58:36'),
(4, 'EQUIPO #4', 'BUENO', 'MARCA #4', 'S000093D', '', '2024-04-22', 'NO', 'HDN', '1713976798_14.xlsx', NULL, 1, NULL, NULL, '', 'ACTIVO', '2024-04-22', 0, '2024-04-22 20:47:18', '2024-05-02 18:24:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cronogramas`
--

CREATE TABLE `cronogramas` (
  `id` bigint UNSIGNED NOT NULL,
  `solicitud_mantenimiento_id` bigint UNSIGNED NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cronogramas`
--

INSERT INTO `cronogramas` (`id`, `solicitud_mantenimiento_id`, `descripcion`, `date`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'INICIO', '2024-02-12', 1, '2024-02-07 23:57:02', '2024-02-07 23:57:02'),
(2, 1, 'FIN', '2024-02-14', 1, '2024-02-07 23:57:02', '2024-02-08 15:12:05'),
(3, 1, 'OTRO', '2024-02-15', 3, '2024-02-08 15:19:47', '2024-02-08 15:19:47'),
(4, 2, 'INICIO SOLICITUD', '2024-02-09', 1, '2024-02-08 15:30:04', '2024-02-08 15:30:04'),
(5, 2, 'FIN SOLICITUD', '2024-02-10', 1, '2024-02-08 15:30:04', '2024-02-08 15:30:04'),
(6, 3, 'INICIO', '2024-02-09', 1, '2024-02-09 00:21:16', '2024-02-09 00:21:16'),
(7, 2, 'CRONOGRAMA USUARIO JEFE DE AREA', '2024-02-13', 4, '2024-02-09 18:46:55', '2024-02-09 18:46:55'),
(8, 2, 'DESC. TENICO', '2024-02-14', 3, '2024-02-09 18:59:08', '2024-02-09 18:59:08'),
(9, 4, 'MATENIMENTO', '2024-04-08', 1, '2024-04-06 16:27:33', '2024-04-06 16:27:33'),
(10, 5, 'DESC', '2024-04-25', 1, '2024-04-24 17:33:39', '2024-04-24 17:33:39'),
(11, 6, 'DESCRIPCION', '2024-05-29', 1, '2024-05-28 14:46:27', '2024-05-28 14:46:27'),
(12, 7, 'INICIO MANTENIMIENTO', '2024-06-18', 3, '2024-06-14 19:50:47', '2024-06-14 19:50:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` bigint UNSIGNED NOT NULL,
  `descripcion` varchar(600) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `descripcion`, `status`, `created_at`, `updated_at`) VALUES
(1, 'DOCUMENTOS #1', 1, '2024-04-06 18:53:15', '2024-04-25 03:03:50'),
(2, 'DOCUMENTOS  2', 1, '2024-04-24 16:50:14', '2024-04-24 16:50:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento_archivos`
--

CREATE TABLE `documento_archivos` (
  `id` bigint UNSIGNED NOT NULL,
  `documento_id` bigint UNSIGNED NOT NULL,
  `archivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documento_archivos`
--

INSERT INTO `documento_archivos` (`id`, `documento_id`, `archivo`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, 'doc_1_17124295951.pdf', 1, '2024-04-06 18:53:15', '2024-04-06 18:53:15'),
(3, 1, 'doc_1_17124295952.pdf', 1, '2024-04-06 18:53:15', '2024-04-06 18:53:15'),
(4, 1, 'doc_1_17124295953.pdf', 1, '2024-04-06 18:53:15', '2024-04-06 18:53:15'),
(5, 1, 'doc_1_17124295954.png', 1, '2024-04-06 18:53:15', '2024-04-06 18:53:15'),
(6, 1, 'doc_1_17124296570.png', 1, '2024-04-06 18:54:17', '2024-04-06 18:54:17'),
(7, 2, 'doc_2_17139774140.pdf', 1, '2024-04-24 16:50:14', '2024-04-24 16:50:14'),
(8, 2, 'doc_2_17139774141.docx', 1, '2024-04-24 16:50:14', '2024-04-24 16:50:14'),
(9, 2, 'doc_2_17139774350.pdf', 1, '2024-04-24 16:50:35', '2024-04-24 16:50:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_ini` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`, `nit`, `fono`, `fecha_ini`, `fecha_fin`, `correo`, `dir`, `pais`, `logo`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'EMPRESA #1', '111111', '7777777', '2024-01-01', '2024-09-03', 'EMPRESA1@GMAIL.COM', 'LOS OLIVOS', 'BOLIVIA', '1718392802_1.png', '2024-02-05', 1, '2024-02-05 22:23:37', '2024-06-14 19:20:02'),
(2, 'EMPRESA #2', '', '', NULL, NULL, '', '', 'BRASIL', NULL, '2024-02-05', 1, '2024-02-05 22:23:45', '2024-04-06 15:57:38'),
(3, 'EMPRESA 3', '33', '33', '2024-03-03', '2024-02-06', '', '', NULL, NULL, '2024-02-05', 1, '2024-02-05 22:24:32', '2024-02-05 22:24:32'),
(4, 'EMPRESA 4', '32322322', '', NULL, NULL, '', '', 'BOLIVIA', NULL, '2024-04-06', 1, '2024-04-06 15:57:52', '2024-04-06 15:57:58'),
(5, 'EMPRESA #5', '123123', '545454545', NULL, NULL, '', '', '', '1718392825_5.png', '2024-06-14', 1, '2024-06-14 19:20:25', '2024-06-14 19:20:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$K9AOPb12uULsg1TRY3QPseyxasLnvrLYkisBXai3aU3gdfQowza5K<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-05 17:19:27<br/>', NULL, 'USUARIOS', '2024-02-05', '17:19:27', '2024-02-05 21:19:27', '2024-02-05 21:19:27'),
(2, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: <br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:31:56<br/>updated_at: 2024-02-05 17:31:56<br/>', NULL, 'UNIDADES Y ÁREAS', '2024-02-05', '17:31:56', '2024-02-05 21:31:56', '2024-02-05 21:31:56'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: <br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:31:56<br/>updated_at: 2024-02-05 17:31:56<br/>', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:31:56<br/>updated_at: 2024-02-05 17:33:16<br/>', 'UNIDADES Y ÁREAS', '2024-02-05', '17:33:16', '2024-02-05 21:33:16', '2024-02-05 21:33:16'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:31:56<br/>updated_at: 2024-02-05 17:33:16<br/>', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:31:56<br/>updated_at: 2024-02-05 17:33:16<br/>', 'UNIDADES Y ÁREAS', '2024-02-05', '17:34:44', '2024-02-05 21:34:44', '2024-02-05 21:34:44'),
(5, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:31:56<br/>updated_at: 2024-02-05 17:33:16<br/>', NULL, 'UNIDADES Y ÁREAS', '2024-02-05', '17:34:48', '2024-02-05 21:34:48', '2024-02-05 21:34:48'),
(6, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-02-05 17:35:08<br/>', NULL, 'UNIDADES Y ÁREAS', '2024-02-05', '17:35:08', '2024-02-05 21:35:08', '2024-02-05 21:35:08'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-02-05 17:35:08<br/>', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-02-05 17:35:08<br/>', 'UNIDADES Y ÁREAS', '2024-02-05', '17:46:12', '2024-02-05 21:46:12', '2024-02-05 21:46:12'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-02-05 17:35:08<br/>', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-02-05 17:35:08<br/>', 'UNIDADES Y ÁREAS', '2024-02-05', '17:47:47', '2024-02-05 21:47:47', '2024-02-05 21:47:47'),
(9, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #1<br/>nit: 11111<br/>fono: 222222<br/>fecha_ini: 2023-01-01<br/>fecha_fin: 2024-01-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS<br/>logo: 1707171353_2.jpg<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:15:53<br/>', NULL, 'EMPRESAS', '2024-02-05', '18:15:53', '2024-02-05 22:15:53', '2024-02-05 22:15:53'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #1<br/>nit: 11111<br/>fono: 222222<br/>fecha_ini: 2023-01-01<br/>fecha_fin: 2024-01-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS<br/>logo: 1707171353_2.jpg<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:15:53<br/>', 'id: 2<br/>nombre: EMPRESA #12<br/>nit: 111112<br/>fono: 2222223<br/>fecha_ini: 2023-02-01<br/>fecha_fin: 2024-03-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS2<br/>logo: 1707171397_2.png<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:16:37<br/>', 'EMPRESAS', '2024-02-05', '18:16:37', '2024-02-05 22:16:37', '2024-02-05 22:16:37'),
(11, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #12<br/>nit: 111112<br/>fono: 2222223<br/>fecha_ini: 2023-02-01<br/>fecha_fin: 2024-03-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS2<br/>logo: 1707171397_2.png<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:16:37<br/>', 'id: 2<br/>nombre: EMPRESA #1<br/>nit: 11111<br/>fono: 222222<br/>fecha_ini: 2023-02-01<br/>fecha_fin: 2024-03-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS2<br/>logo: 1707171397_2.png<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:16:47<br/>', 'EMPRESAS', '2024-02-05', '18:16:47', '2024-02-05 22:16:47', '2024-02-05 22:16:47'),
(12, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #1<br/>nit: 11111<br/>fono: 222222<br/>fecha_ini: 2023-02-01<br/>fecha_fin: 2024-03-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS2<br/>logo: 1707171397_2.png<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:16:47<br/>', 'id: 2<br/>nombre: EMPRESA #1<br/>nit: 11111<br/>fono: 222222<br/>fecha_ini: 2023-02-01<br/>fecha_fin: 2024-03-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS2<br/>logo: 1707171578_2.jpg<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:19:38<br/>', 'EMPRESAS', '2024-02-05', '18:19:38', '2024-02-05 22:19:38', '2024-02-05 22:19:38'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA EMPRESA', 'id: 3<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:20:50<br/>updated_at: 2024-02-05 18:20:50<br/>', NULL, 'EMPRESAS', '2024-02-05', '18:20:50', '2024-02-05 22:20:50', '2024-02-05 22:20:50'),
(14, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA EMPRESA', 'id: 3<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:20:50<br/>updated_at: 2024-02-05 18:20:50<br/>', NULL, 'EMPRESAS', '2024-02-05', '18:22:54', '2024-02-05 22:22:54', '2024-02-05 22:22:54'),
(15, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #1<br/>nit: 11111<br/>fono: 222222<br/>fecha_ini: 2023-02-01<br/>fecha_fin: 2024-03-01<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS2<br/>logo: 1707171578_2.jpg<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:15:53<br/>updated_at: 2024-02-05 18:19:38<br/>', NULL, 'EMPRESAS', '2024-02-05', '18:22:59', '2024-02-05 22:22:59', '2024-02-05 22:22:59'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA EMPRESA', 'id: 1<br/>nombre: EMPRESA #1<br/>nit: 111111<br/>fono: 7777777<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-09-03<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS<br/>logo: 1707171817_1.jpg<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:37<br/>updated_at: 2024-02-05 18:23:37<br/>', NULL, 'EMPRESAS', '2024-02-05', '18:23:37', '2024-02-05 22:23:37', '2024-02-05 22:23:37'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:45<br/>updated_at: 2024-02-05 18:23:45<br/>', NULL, 'EMPRESAS', '2024-02-05', '18:23:45', '2024-02-05 22:23:45', '2024-02-05 22:23:45'),
(18, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA EMPRESA', 'id: 3<br/>nombre: EMPRESA 3<br/>nit: 33<br/>fono: 33<br/>fecha_ini: 2024-03-03<br/>fecha_fin: 2024-02-06<br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:24:32<br/>updated_at: 2024-02-05 18:24:32<br/>', NULL, 'EMPRESAS', '2024-02-05', '18:24:32', '2024-02-05 22:24:32', '2024-02-05 22:24:32'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:45<br/>updated_at: 2024-02-05 18:23:45<br/>', 'id: 2<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:45<br/>updated_at: 2024-02-05 18:23:45<br/>', 'EMPRESAS', '2024-02-05', '18:25:01', '2024-02-05 22:25:01', '2024-02-05 22:25:01'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: <br/>manual_usuario: 1707234795_1.pdf<br/>manual_servicio: 1707234795_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 11:53:15<br/>', NULL, 'BIOMETRICOS', '2024-02-06', '11:53:15', '2024-02-06 15:53:15', '2024-02-06 15:53:15'),
(21, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: <br/>manual_usuario: 1707234795_1.pdf<br/>manual_servicio: 1707234795_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 11:53:15<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707234795_1.pdf<br/>manual_servicio: 1707234795_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 11:54:37<br/>', 'BIOMETRICOS', '2024-02-06', '11:54:37', '2024-02-06 15:54:37', '2024-02-06 15:54:37'),
(22, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707234795_1.pdf<br/>manual_servicio: 1707234795_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 11:54:37<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707234795_1.pdf<br/>manual_servicio: 1707237952_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 12:45:52<br/>', 'BIOMETRICOS', '2024-02-06', '12:45:52', '2024-02-06 16:45:52', '2024-02-06 16:45:52'),
(23, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707234795_1.pdf<br/>manual_servicio: 1707237952_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 12:45:52<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707237964_1.pdf<br/>manual_servicio: 1707237952_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 12:46:04<br/>', 'BIOMETRICOS', '2024-02-06', '12:46:04', '2024-02-06 16:46:04', '2024-02-06 16:46:04'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707237964_1.pdf<br/>manual_servicio: 1707237952_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 12:46:04<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707237976_1.pdf<br/>manual_servicio: 1707237976_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 12:46:16<br/>', 'BIOMETRICOS', '2024-02-06', '12:46:16', '2024-02-06 16:46:16', '2024-02-06 16:46:16'),
(25, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: 00-E2B<br/>serie: S001-E<br/>modelo: M001-4<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707237976_1.pdf<br/>manual_servicio: 1707237976_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707234795_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 11:53:15<br/>updated_at: 2024-02-06 12:46:16<br/>', NULL, 'BIOMETRICOS', '2024-02-06', '12:46:23', '2024-02-06 16:46:23', '2024-02-06 16:46:23'),
(26, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #1<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2023-01-01<br/>garantia: <br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: <br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:47:00<br/>updated_at: 2024-02-06 12:47:00<br/>', NULL, 'BIOMETRICOS', '2024-02-06', '12:47:00', '2024-02-06 16:47:00', '2024-02-06 16:47:00'),
(27, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #1<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2023-01-01<br/>garantia: <br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: <br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:47:00<br/>updated_at: 2024-02-06 12:47:00<br/>', 'id: 2<br/>nombre: EQUIPO #1<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2023-01-01<br/>garantia: <br/>cod_hdn: ASD<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: <br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:47:00<br/>updated_at: 2024-02-06 12:47:19<br/>', 'BIOMETRICOS', '2024-02-06', '12:47:19', '2024-02-06 16:47:19', '2024-02-06 16:47:19'),
(28, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #1<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2023-01-01<br/>garantia: <br/>cod_hdn: ASD<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: <br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:47:00<br/>updated_at: 2024-02-06 12:47:19<br/>', NULL, 'BIOMETRICOS', '2024-02-06', '12:47:24', '2024-02-06 16:47:24', '2024-02-06 16:47:24'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707238084_1.pdf<br/>manual_servicio: 1707238084_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-02-06 12:48:04<br/>', NULL, 'BIOMETRICOS', '2024-02-06', '12:48:04', '2024-02-06 16:48:04', '2024-02-06 16:48:04'),
(30, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 1<br/>nombre: REPUESTO #1<br/>created_at: 2024-02-06 12:57:55<br/>updated_at: 2024-02-06 12:57:55<br/>', NULL, 'REPUESTOS', '2024-02-06', '12:57:55', '2024-02-06 16:57:55', '2024-02-06 16:57:55'),
(31, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>nombre: REPUESTO #1<br/>created_at: 2024-02-06 12:57:55<br/>updated_at: 2024-02-06 12:57:55<br/>', 'id: 1<br/>nombre: REPUESTO #1ASD<br/>created_at: 2024-02-06 12:57:55<br/>updated_at: 2024-02-06 12:58:46<br/>', 'REPUESTOS', '2024-02-06', '12:58:46', '2024-02-06 16:58:46', '2024-02-06 16:58:46'),
(32, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN REPUESTO', 'id: 1<br/>nombre: REPUESTO #1ASD<br/>created_at: 2024-02-06 12:57:55<br/>updated_at: 2024-02-06 12:58:46<br/>', NULL, 'REPUESTOS', '2024-02-06', '12:58:55', '2024-02-06 16:58:55', '2024-02-06 16:58:55'),
(33, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 1<br/>nombre: REPUESTO #1<br/>created_at: 2024-02-06 12:59:34<br/>updated_at: 2024-02-06 12:59:34<br/>', NULL, 'REPUESTOS', '2024-02-06', '12:59:34', '2024-02-06 16:59:34', '2024-02-06 16:59:34'),
(34, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 2<br/>nombre: REPUESTO #2<br/>created_at: 2024-02-06 12:59:50<br/>updated_at: 2024-02-06 12:59:50<br/>', NULL, 'REPUESTOS', '2024-02-06', '12:59:50', '2024-02-06 16:59:50', '2024-02-06 16:59:50'),
(35, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$K9AOPb12uULsg1TRY3QPseyxasLnvrLYkisBXai3aU3gdfQowza5K<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-05 17:19:27<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$K9AOPb12uULsg1TRY3QPseyxasLnvrLYkisBXai3aU3gdfQowza5K<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-05 17:19:27<br/>', 'USUARIOS', '2024-02-06', '13:01:24', '2024-02-06 17:01:24', '2024-02-06 17:01:24'),
(36, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 1<br/>codigo: <br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: <br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', NULL, 'REPUESTOS', '2024-02-07', '18:15:43', '2024-02-07 22:15:43', '2024-02-07 22:15:43'),
(37, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:28:23', '2024-02-07 23:28:23', '2024-02-07 23:28:23'),
(38, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:29:13', '2024-02-07 23:29:13', '2024-02-07 23:29:13'),
(39, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:30:16', '2024-02-07 23:30:16', '2024-02-07 23:30:16'),
(40, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:31:07', '2024-02-07 23:31:07', '2024-02-07 23:31:07'),
(41, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:32:37', '2024-02-07 23:32:37', '2024-02-07 23:32:37'),
(42, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:33:44', '2024-02-07 23:33:44', '2024-02-07 23:33:44'),
(43, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:34:06', '2024-02-07 23:34:06', '2024-02-07 23:34:06'),
(44, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:34:24', '2024-02-07 23:34:24', '2024-02-07 23:34:24'),
(45, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:36:46', '2024-02-07 23:36:46', '2024-02-07 23:36:46'),
(46, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:38:48', '2024-02-07 23:38:48', '2024-02-07 23:38:48'),
(47, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:42:22', '2024-02-07 23:42:22', '2024-02-07 23:42:22'),
(48, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'REPUESTOS', '2024-02-07', '19:42:40', '2024-02-07 23:42:40', '2024-02-07 23:42:40'),
(49, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN<br/>ci_responsable: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 18:15:42<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:51:00<br/>', 'REPUESTOS', '2024-02-07', '19:51:00', '2024-02-07 23:51:00', '2024-02-07 23:51:00'),
(50, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:51:00<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:51:00<br/>', 'REPUESTOS', '2024-02-07', '19:51:08', '2024-02-07 23:51:08', '2024-02-07 23:51:08'),
(51, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:51:00<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:51:00<br/>', 'REPUESTOS', '2024-02-07', '19:51:34', '2024-02-07 23:51:34', '2024-02-07 23:51:34'),
(52, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:51:00<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:52:17<br/>', 'REPUESTOS', '2024-02-07', '19:52:17', '2024-02-07 23:52:17', '2024-02-07 23:52:17'),
(53, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO MAMANI<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: DIAGNOSTICO<br/>otros: OTROS<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 18:15:42<br/>updated_at: 2024-02-07 19:52:17<br/>', NULL, 'REPUESTOS', '2024-02-07', '19:53:02', '2024-02-07 23:53:02', '2024-02-07 23:53:02'),
(54, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 2<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: ASD<br/>ci_responsable: 123<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:54:20<br/>updated_at: 2024-02-07 19:54:20<br/>', NULL, 'REPUESTOS', '2024-02-07', '19:54:20', '2024-02-07 23:54:20', '2024-02-07 23:54:20'),
(55, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN REPUESTO', 'id: 2<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: ASD<br/>ci_responsable: 123<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:54:20<br/>updated_at: 2024-02-07 19:54:20<br/>', NULL, 'REPUESTOS', '2024-02-07', '19:54:25', '2024-02-07 23:54:25', '2024-02-07 23:54:25'),
(56, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 3<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: ASD<br/>ci_responsable: 123<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: ASD<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:55:20<br/>updated_at: 2024-02-07 19:55:20<br/>', NULL, 'REPUESTOS', '2024-02-07', '19:55:20', '2024-02-07 23:55:20', '2024-02-07 23:55:20'),
(57, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN REPUESTO', 'id: 3<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: ASD<br/>ci_responsable: 123<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: ASD<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:55:20<br/>updated_at: 2024-02-07 19:55:20<br/>', NULL, 'REPUESTOS', '2024-02-07', '19:55:25', '2024-02-07 23:55:25', '2024-02-07 23:55:25'),
(58, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-02-07 19:57:02<br/>', NULL, 'REPUESTOS', '2024-02-07', '19:57:02', '2024-02-07 23:57:02', '2024-02-07 23:57:02'),
(59, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-02-07 19:57:02<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-02-07 19:57:02<br/>', 'REPUESTOS', '2024-02-08', '11:12:05', '2024-02-08 15:12:05', '2024-02-08 15:12:05'),
(60, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 3<br/>usuario: FPAREDES<br/>password: $2y$12$jQnFeAHVj3iptVZQKnFPlebgMqFp9IccVui5FS6YGpjz9KLSvqVl.<br/>nombre: FERNANDO<br/>paterno: PAREDES<br/>materno: MAMANI<br/>ci: 2222<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 777777<br/>tipo: TÉCNICO<br/>foto: <br/>acceso: 1<br/>fecha_registro: 2024-02-08 00:00:00<br/>created_at: 2024-02-08 11:16:00<br/>updated_at: 2024-02-08 11:16:01<br/>', NULL, 'USUARIOS', '2024-02-08', '11:16:01', '2024-02-08 15:16:01', '2024-02-08 15:16:01'),
(61, 3, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-02-07 19:57:02<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: PREVENTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: 2024-02-15<br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-02-08 11:19:47<br/>', 'REPUESTOS', '2024-02-08', '11:19:47', '2024-02-08 15:19:47', '2024-02-08 15:19:47'),
(62, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 4<br/>usuario: MMAMANI<br/>password: $2y$12$VJ37jS9TwD/ep6JTtJ0nnuKpHAgcgP.nJzHka.8knnKOiENrhp3Sq<br/>nombre: MARIA<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 3333<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 77777<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>acceso: 1<br/>fecha_registro: 2024-02-08 00:00:00<br/>created_at: 2024-02-08 11:26:19<br/>updated_at: 2024-02-08 11:26:19<br/>', NULL, 'USUARIOS', '2024-02-08', '11:26:19', '2024-02-08 15:26:19', '2024-02-08 15:26:19'),
(63, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA UNIDAD/ÁREA', 'id: 2<br/>nombre: AREA #2<br/>descripcion: DESC<br/>user_id: 4<br/>ubicacion: UBICACION AREA #2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:35<br/>updated_at: 2024-02-08 11:26:35<br/>', NULL, 'UNIDADES Y ÁREAS', '2024-02-08', '11:26:35', '2024-02-08 15:26:35', '2024-02-08 15:26:35'),
(64, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: <br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 2<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-02-08 11:26:52<br/>', NULL, 'BIOMETRICOS', '2024-02-08', '11:26:52', '2024-02-08 15:26:52', '2024-02-08 15:26:52'),
(65, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: <br/>biometrico_id: 2<br/>repuestos: 1<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-08 11:30:04<br/>', NULL, 'REPUESTOS', '2024-02-08', '11:30:04', '2024-02-08 15:30:04', '2024-02-08 15:30:04'),
(66, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESCRIPCION CAPACITCACION<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-10<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:00:00<br/>', NULL, 'SERVICIOS', '2024-02-08', '15:00:00', '2024-02-08 19:00:00', '2024-02-08 19:00:00'),
(67, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESCRIPCION CAPACITCACION<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-10<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:00:00<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: NO<br/>descripcion: <br/>fecha_ini: <br/>fecha_fin: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:35:13<br/>', 'SERVICIOS', '2024-02-08', '15:35:13', '2024-02-08 19:35:13', '2024-02-08 19:35:13'),
(68, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: NO<br/>descripcion: <br/>fecha_ini: <br/>fecha_fin: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:35:13<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'SERVICIOS', '2024-02-08', '15:36:00', '2024-02-08 19:36:00', '2024-02-08 19:36:00'),
(69, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: <br/>biometrico_id: 2<br/>repuestos: 1<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-08 11:30:04<br/>', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: <br/>biometrico_id: 2<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-08 15:36:45<br/>', 'REPUESTOS', '2024-02-08', '15:36:45', '2024-02-08 19:36:45', '2024-02-08 19:36:45');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(70, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'SERVICIOS', '2024-02-08', '19:51:06', '2024-02-08 23:51:06', '2024-02-08 23:51:06'),
(71, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN BIOMETRICO', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: <br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-02-08 20:20:37<br/>', NULL, 'BIOMETRICOS', '2024-02-08', '20:20:37', '2024-02-09 00:20:37', '2024-02-09 00:20:37'),
(72, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 3<br/>codigo: SOL.MAT.3<br/>nro: 3<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>nombre_tecnico: FERNANDO CORTEZ<br/>ci_tecnico: 3333<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: <br/>biometrico_id: 3<br/>repuestos: 2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:21:16<br/>updated_at: 2024-02-08 20:21:16<br/>', NULL, 'REPUESTOS', '2024-02-08', '20:21:16', '2024-02-09 00:21:16', '2024-02-09 00:21:16'),
(73, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN SERVICIO', 'id: 2<br/>solicitud_mantenimiento_id: 2<br/>fecha_entrega: 2024-02-09<br/>procedimientos: PROCEDIMIENTOS #2<br/>observaciones: OBSERVACIONES #2<br/>recomendaciones: <br/>diagnostico_previo: <br/>estado_equipo: <br/>trabajo_realizado: TRABAJO REALIZADO #2<br/>capacitacion: NO<br/>descripcion: <br/>fecha_ini: <br/>fecha_fin: <br/>fecha_registro: 2024-02-09<br/>created_at: 2024-02-09 14:35:42<br/>updated_at: 2024-02-09 14:35:42<br/>', NULL, 'SERVICIOS', '2024-02-09', '14:35:42', '2024-02-09 18:35:42', '2024-02-09 18:35:42'),
(74, 4, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: 2024-02-09<br/>biometrico_id: 2<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-09 14:35:42<br/>', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: 2024-02-09<br/>biometrico_id: 2<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-09 14:35:42<br/>', 'REPUESTOS', '2024-02-09', '14:46:55', '2024-02-09 18:46:55', '2024-02-09 18:46:55'),
(75, 3, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: 2024-02-09<br/>biometrico_id: 2<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-09 14:35:42<br/>', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: CORRECTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: 2024-02-09<br/>biometrico_id: 2<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-09 14:59:08<br/>', 'REPUESTOS', '2024-02-09', '14:59:08', '2024-02-09 18:59:08', '2024-02-09 18:59:08'),
(76, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$K9AOPb12uULsg1TRY3QPseyxasLnvrLYkisBXai3aU3gdfQowza5K<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-05 17:19:27<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$U0EYn.Y7mE/2sr8LstsXuO3V2cKBHES5yzkrSMY3dU/AuXee/beey<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-20 14:16:40<br/>', 'USUARIOS', '2024-02-20', '14:16:40', '2024-02-20 18:16:40', '2024-02-20 18:16:40'),
(77, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$U0EYn.Y7mE/2sr8LstsXuO3V2cKBHES5yzkrSMY3dU/AuXee/beey<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-20 14:16:40<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$F4V/Na8QTZwb65NtnbHeje3W/PK6UlJA3QQUWiqIXXARjrG.wp9L.<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-20 14:17:00<br/>', 'USUARIOS', '2024-02-20', '14:17:00', '2024-02-20 18:17:00', '2024-02-20 18:17:00'),
(78, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$F4V/Na8QTZwb65NtnbHeje3W/PK6UlJA3QQUWiqIXXARjrG.wp9L.<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-20 14:17:00<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-20 14:17:17<br/>', 'USUARIOS', '2024-02-20', '14:17:17', '2024-02-20 18:17:17', '2024-02-20 18:17:17'),
(79, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 5<br/>usuario: AMAMANI<br/>password: $2y$12$DbDh0axGVKOwwYdPlYUD4.PLEcqupIdP17jti8Kp0edHB3xpZjJcG<br/>nombre: ALEXIS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 5555<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: ALEX@GMAIL.COM<br/>fono: 77777<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>acceso: 1<br/>fecha_registro: 2024-02-20 00:00:00<br/>created_at: 2024-02-20 15:49:05<br/>updated_at: 2024-02-20 15:49:05<br/>', NULL, 'USUARIOS', '2024-02-20', '15:49:05', '2024-02-20 19:49:05', '2024-02-20 19:49:05'),
(80, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-02-20 14:17:17<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234ASD<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-04-06 11:27:41<br/>', 'USUARIOS', '2024-04-06', '11:27:41', '2024-04-06 15:27:41', '2024-04-06 15:27:41'),
(81, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234ASD<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-04-06 11:27:41<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234-ABC<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-04-06 11:28:28<br/>', 'USUARIOS', '2024-04-06', '11:28:28', '2024-04-06 15:28:28', '2024-04-06 15:28:28'),
(82, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234-ABC<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-04-06 11:28:28<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-04-06 11:28:33<br/>', 'USUARIOS', '2024-04-06', '11:28:33', '2024-04-06 15:28:33', '2024-04-06 15:28:33'),
(83, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1707238084_1.pdf<br/>manual_servicio: 1707238084_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-02-06 12:48:04<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1707238084_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:30:05<br/>', 'BIOMETRICOS', '2024-04-06', '11:30:05', '2024-04-06 15:30:05', '2024-04-06 15:30:05'),
(84, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1707238084_1.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:30:05<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:30:17<br/>', 'BIOMETRICOS', '2024-04-06', '11:30:17', '2024-04-06 15:30:17', '2024-04-06 15:30:17'),
(85, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-04-06 11:28:33<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 777777<br/>tipo: JEFE DE ÁREA<br/>foto: 1707167967_JPERES.jpg<br/>item: 111111<br/>acceso: 1<br/>fecha_registro: 2024-02-05 00:00:00<br/>created_at: 2024-02-05 17:19:27<br/>updated_at: 2024-04-06 11:43:03<br/>', 'USUARIOS', '2024-04-06', '11:43:03', '2024-04-06 15:43:03', '2024-04-06 15:43:03'),
(86, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 6<br/>usuario: RCONTRERAS<br/>password: $2y$12$pgYF5E0.wogTKnvRE7x7A.MtYqHOuRi7By431ljqeW5kseTABqc5W<br/>nombre: RAMIRO<br/>paterno: CONTRERAS<br/>materno: <br/>ci: 6666<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 77777777<br/>tipo: DIRECTOR<br/>foto: <br/>item: I-003333<br/>acceso: 1<br/>fecha_registro: 2024-04-06 00:00:00<br/>created_at: 2024-04-06 11:44:01<br/>updated_at: 2024-04-06 11:44:01<br/>', NULL, 'USUARIOS', '2024-04-06', '11:44:01', '2024-04-06 15:44:01', '2024-04-06 15:44:01'),
(87, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>unidad: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-02-05 17:35:08<br/>', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>unidad: UNIDAD #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-04-06 11:53:39<br/>', 'UNIDADES Y ÁREAS', '2024-04-06', '11:53:39', '2024-04-06 15:53:39', '2024-04-06 15:53:39'),
(88, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 2<br/>nombre: AREA #2<br/>descripcion: DESC<br/>user_id: 4<br/>ubicacion: UBICACION AREA #2<br/>unidad: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:35<br/>updated_at: 2024-02-08 11:26:35<br/>', 'id: 2<br/>nombre: AREA #2<br/>descripcion: DESC<br/>user_id: 4<br/>ubicacion: UBICACION AREA #2<br/>unidad: UNIDAD #2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:35<br/>updated_at: 2024-04-06 11:53:43<br/>', 'UNIDADES Y ÁREAS', '2024-04-06', '11:53:43', '2024-04-06 15:53:43', '2024-04-06 15:53:43'),
(89, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA UNIDAD/ÁREA', 'id: 3<br/>nombre: AREA #3<br/>descripcion: <br/>user_id: 5<br/>ubicacion: UBICACION AREA #3<br/>unidad: UNIDAD #2<br/>fecha_registro: 2024-04-06<br/>created_at: 2024-04-06 11:54:33<br/>updated_at: 2024-04-06 11:54:33<br/>', NULL, 'UNIDADES Y ÁREAS', '2024-04-06', '11:54:33', '2024-04-06 15:54:33', '2024-04-06 15:54:33'),
(90, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: UNIDAD #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>unidad: UNIDAD #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-04-06 11:53:39<br/>', 'id: 1<br/>nombre: AREA #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>unidad: UNIDAD #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-04-06 11:54:40<br/>', 'UNIDADES Y ÁREAS', '2024-04-06', '11:54:40', '2024-04-06 15:54:40', '2024-04-06 15:54:40'),
(91, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 1<br/>nombre: EMPRESA #1<br/>nit: 111111<br/>fono: 7777777<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-09-03<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS<br/>pais: <br/>logo: 1707171817_1.jpg<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:37<br/>updated_at: 2024-02-05 18:23:37<br/>', 'id: 1<br/>nombre: EMPRESA #1<br/>nit: 111111<br/>fono: 7777777<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-09-03<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS<br/>pais: BOLIVIA<br/>logo: 1707171817_1.jpg<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:37<br/>updated_at: 2024-04-06 11:57:31<br/>', 'EMPRESAS', '2024-04-06', '11:57:31', '2024-04-06 15:57:31', '2024-04-06 15:57:31'),
(92, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>pais: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:45<br/>updated_at: 2024-02-05 18:23:45<br/>', 'id: 2<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>pais: BRASIL<br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:45<br/>updated_at: 2024-04-06 11:57:38<br/>', 'EMPRESAS', '2024-04-06', '11:57:38', '2024-04-06 15:57:38', '2024-04-06 15:57:38'),
(93, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA EMPRESA', 'id: 4<br/>nombre: EMPRESA 4<br/>nit: 32322322<br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>pais: <br/>logo: <br/>fecha_registro: 2024-04-06<br/>created_at: 2024-04-06 11:57:52<br/>updated_at: 2024-04-06 11:57:52<br/>', NULL, 'EMPRESAS', '2024-04-06', '11:57:52', '2024-04-06 15:57:52', '2024-04-06 15:57:52'),
(94, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 4<br/>nombre: EMPRESA 4<br/>nit: 32322322<br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>pais: <br/>logo: <br/>fecha_registro: 2024-04-06<br/>created_at: 2024-04-06 11:57:52<br/>updated_at: 2024-04-06 11:57:52<br/>', 'id: 4<br/>nombre: EMPRESA 4<br/>nit: 32322322<br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>pais: BOLIVIA<br/>logo: <br/>fecha_registro: 2024-04-06<br/>created_at: 2024-04-06 11:57:52<br/>updated_at: 2024-04-06 11:57:58<br/>', 'EMPRESAS', '2024-04-06', '11:57:58', '2024-04-06 15:57:58', '2024-04-06 15:57:58'),
(95, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:30:17<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULARS<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:58:45<br/>', 'BIOMETRICOS', '2024-04-06', '11:58:45', '2024-04-06 15:58:45', '2024-04-06 15:58:45'),
(96, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULARS<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:58:45<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:58:50<br/>', 'BIOMETRICOS', '2024-04-06', '11:58:50', '2024-04-06 15:58:50', '2024-04-06 15:58:50'),
(97, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: 2 AÑOS<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:58:50<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: SI<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:59:56<br/>', 'BIOMETRICOS', '2024-04-06', '11:59:56', '2024-04-06 15:59:56', '2024-04-06 15:59:56'),
(98, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: <br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 2<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-02-08 11:26:52<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 2<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:00:01<br/>', 'BIOMETRICOS', '2024-04-06', '12:00:01', '2024-04-06 16:00:01', '2024-04-06 16:00:01'),
(99, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: <br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-02-08 20:20:37<br/>', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-04-06 12:00:05<br/>', 'BIOMETRICOS', '2024-04-06', '12:00:05', '2024-04-06 16:00:05', '2024-04-06 16:00:05'),
(100, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: SI<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:59:56<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: SI<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:59:56<br/>', 'BIOMETRICOS', '2024-04-06', '12:00:36', '2024-04-06 16:00:36', '2024-04-06 16:00:36'),
(101, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 2<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:00:01<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:02:58<br/>', 'BIOMETRICOS', '2024-04-06', '12:02:58', '2024-04-06 16:02:58', '2024-04-06 16:02:58'),
(102, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:02:58<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 4<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:04:12<br/>', 'BIOMETRICOS', '2024-04-06', '12:04:12', '2024-04-06 16:04:12', '2024-04-06 16:04:12'),
(103, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 4<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:04:12<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:04:18<br/>', 'BIOMETRICOS', '2024-04-06', '12:04:18', '2024-04-06 16:04:18', '2024-04-06 16:04:18'),
(104, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-04-06 12:00:05<br/>', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-04-06 12:00:05<br/>', 'BIOMETRICOS', '2024-04-06', '12:15:46', '2024-04-06 16:15:46', '2024-04-06 16:15:46'),
(105, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>responsable_id: <br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>tecnico_id: <br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: PREVENTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: 2024-02-08<br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-02-08 19:51:06<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>responsable_id: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>tecnico_id: 3<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: PREVENTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: 2024-02-08<br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-04-06 12:23:59<br/>', 'REPUESTOS', '2024-04-06', '12:23:59', '2024-04-06 16:23:59', '2024-04-06 16:23:59'),
(106, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 3<br/>codigo: SOL.MAT.3<br/>nro: 3<br/>responsable_id: <br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>tecnico_id: <br/>nombre_tecnico: FERNANDO CORTEZ<br/>ci_tecnico: 3333<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: <br/>biometrico_id: 3<br/>repuestos: 2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:21:16<br/>updated_at: 2024-02-08 20:21:16<br/>', 'id: 3<br/>codigo: SOL.MAT.3<br/>nro: 3<br/>responsable_id: 4<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>tecnico_id: 3<br/>nombre_tecnico: FERNANDO CORTEZ<br/>ci_tecnico: 3333<br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: <br/>biometrico_id: 3<br/>repuestos: 2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:21:16<br/>updated_at: 2024-04-06 12:24:14<br/>', 'REPUESTOS', '2024-04-06', '12:24:14', '2024-04-06 16:24:14', '2024-04-06 16:24:14'),
(107, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>responsable_id: <br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>tecnico_id: <br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: CORRECTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: 2024-02-09<br/>biometrico_id: 2<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-02-09 14:59:08<br/>', 'id: 2<br/>codigo: SOL.MAT.2<br/>nro: 2<br/>responsable_id: 5<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 2222<br/>tecnico_id: 3<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: CORRECTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-02-08<br/>fecha_entrega: 2024-02-09<br/>biometrico_id: 2<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:30:04<br/>updated_at: 2024-04-06 12:26:10<br/>', 'REPUESTOS', '2024-04-06', '12:26:10', '2024-04-06 16:26:10', '2024-04-06 16:26:10'),
(108, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 4<br/>codigo: SOL.MAT.4<br/>nro: 4<br/>responsable_id: 2<br/>nombre_responsable: <br/>ci_responsable: <br/>tecnico_id: 3<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANT. #4<br/>diagnostico: DIAGNOSTICO<br/>otros: <br/>fecha_solicitud: 2024-04-06<br/>fecha_entrega: <br/>biometrico_id: 2<br/>repuestos: 1<br/>fecha_registro: 2024-04-06<br/>created_at: 2024-04-06 12:27:33<br/>updated_at: 2024-04-06 12:27:33<br/>', NULL, 'REPUESTOS', '2024-04-06', '12:27:33', '2024-04-06 16:27:33', '2024-04-06 16:27:33'),
(109, 3, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 4<br/>codigo: SOL.MAT.4<br/>nro: 4<br/>responsable_id: 2<br/>nombre_responsable: <br/>ci_responsable: <br/>tecnico_id: 3<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO MANT. #4<br/>diagnostico: DIAGNOSTICO<br/>otros: <br/>fecha_solicitud: 2024-04-06<br/>fecha_entrega: <br/>biometrico_id: 2<br/>repuestos: 1<br/>fecha_registro: 2024-04-06<br/>created_at: 2024-04-06 12:27:33<br/>updated_at: 2024-04-06 12:27:33<br/>', 'id: 4<br/>codigo: SOL.MAT.4<br/>nro: 4<br/>responsable_id: 2<br/>nombre_responsable: <br/>ci_responsable: <br/>tecnico_id: 3<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: CORRECTIVO<br/>motivo_mantenimiento: MOTIVO MANT. #4<br/>diagnostico: DIAGNOSTICO<br/>otros: <br/>fecha_solicitud: 2024-04-06<br/>fecha_entrega: <br/>biometrico_id: 2<br/>repuestos: 1<br/>fecha_registro: 2024-04-06<br/>created_at: 2024-04-06 12:27:33<br/>updated_at: 2024-04-06 12:28:01<br/>', 'REPUESTOS', '2024-04-06', '12:28:01', '2024-04-06 16:28:01', '2024-04-06 16:28:01'),
(110, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>nombre: REPUESTO #1<br/>created_at: 2024-02-06 12:59:34<br/>updated_at: 2024-02-06 12:59:34<br/>', 'id: 1<br/>nombre: REPUESTO #1<br/>created_at: 2024-02-06 12:59:34<br/>updated_at: 2024-02-06 12:59:34<br/>', 'REPUESTOS', '2024-04-06', '12:35:46', '2024-04-06 16:35:46', '2024-04-06 16:35:46'),
(111, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:04:18<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:39:01<br/>', 'BIOMETRICOS', '2024-04-06', '12:39:01', '2024-04-06 16:39:01', '2024-04-06 16:39:01'),
(112, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:39:01<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:39:40<br/>', 'BIOMETRICOS', '2024-04-06', '12:39:40', '2024-04-06 16:39:40', '2024-04-06 16:39:40'),
(113, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN DOCUMENTO', 'id: 1<br/>descripcion: DOCUMENTOS #1<br/>created_at: 2024-04-06 14:53:15<br/>updated_at: 2024-04-06 14:53:15<br/>', NULL, 'DOCUMENTOS', '2024-04-06', '14:53:15', '2024-04-06 18:53:15', '2024-04-06 18:53:15'),
(114, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN DOCUMENTO', 'id: 1<br/>descripcion: DOCUMENTOS #1<br/>created_at: 2024-04-06 14:53:15<br/>updated_at: 2024-04-06 14:53:15<br/>', 'id: 1<br/>descripcion: DOCUMENTOS #1<br/>created_at: 2024-04-06 14:53:15<br/>updated_at: 2024-04-06 14:53:15<br/>', 'DOCUMENTOS', '2024-04-06', '14:54:17', '2024-04-06 18:54:17', '2024-04-06 18:54:17'),
(115, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN BIOMETRICO', 'id: 4<br/>nombre: EQUIPO #4<br/>estado: BUENO<br/>marca: MARCA #4<br/>serie: S000093D<br/>modelo: <br/>fecha_ingreso: 2024-04-22<br/>garantia: NO<br/>cod_hdn: HDN<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-04-22<br/>created_at: 2024-04-22 16:47:18<br/>updated_at: 2024-04-22 16:47:18<br/>', NULL, 'BIOMETRICOS', '2024-04-22', '16:47:19', '2024-04-22 20:47:19', '2024-04-22 20:47:19'),
(116, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 4<br/>nombre: EQUIPO #4<br/>estado: BUENO<br/>marca: MARCA #4<br/>serie: S000093D<br/>modelo: <br/>fecha_ingreso: 2024-04-22<br/>garantia: NO<br/>cod_hdn: HDN<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-04-22<br/>created_at: 2024-04-22 16:47:18<br/>updated_at: 2024-04-22 16:47:18<br/>', 'id: 4<br/>nombre: EQUIPO #4<br/>estado: BUENO<br/>marca: MARCA #4<br/>serie: S000093D<br/>modelo: <br/>fecha_ingreso: 2024-04-22<br/>garantia: NO<br/>cod_hdn: HDN<br/>manual_usuario: 1713976798_14.xlsx<br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: <br/>foto: <br/>fecha_registro: 2024-04-22<br/>created_at: 2024-04-22 16:47:18<br/>updated_at: 2024-04-24 12:39:58<br/>', 'BIOMETRICOS', '2024-04-24', '12:39:58', '2024-04-24 16:39:58', '2024-04-24 16:39:58'),
(117, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN DOCUMENTO', 'id: 2<br/>descripcion: DOCUMENTOS  2<br/>created_at: 2024-04-24 12:50:14<br/>updated_at: 2024-04-24 12:50:14<br/>', NULL, 'DOCUMENTOS', '2024-04-24', '12:50:14', '2024-04-24 16:50:14', '2024-04-24 16:50:14'),
(118, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN DOCUMENTO', 'id: 2<br/>descripcion: DOCUMENTOS  2<br/>created_at: 2024-04-24 12:50:14<br/>updated_at: 2024-04-24 12:50:14<br/>', 'id: 2<br/>descripcion: DOCUMENTOS  2<br/>created_at: 2024-04-24 12:50:14<br/>updated_at: 2024-04-24 12:50:14<br/>', 'DOCUMENTOS', '2024-04-24', '12:50:28', '2024-04-24 16:50:28', '2024-04-24 16:50:28'),
(119, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN DOCUMENTO', 'id: 2<br/>descripcion: DOCUMENTOS  2<br/>created_at: 2024-04-24 12:50:14<br/>updated_at: 2024-04-24 12:50:14<br/>', 'id: 2<br/>descripcion: DOCUMENTOS  2<br/>created_at: 2024-04-24 12:50:14<br/>updated_at: 2024-04-24 12:50:14<br/>', 'DOCUMENTOS', '2024-04-24', '12:50:35', '2024-04-24 16:50:35', '2024-04-24 16:50:35'),
(120, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:04:18<br/>', NULL, 'USUARIOS', '2024-04-24', '13:04:18', '2024-04-24 17:04:18', '2024-04-24 17:04:18'),
(121, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: AREA #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>unidad: UNIDAD #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-04-06 11:54:40<br/>', 'id: 1<br/>nombre: AREA #1<br/>descripcion: DESC. #1<br/>user_id: 7<br/>ubicacion: UBICACION #1<br/>unidad: UNIDAD #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-04-24 13:30:57<br/>', 'UNIDADES Y ÁREAS', '2024-04-24', '13:30:57', '2024-04-24 17:30:57', '2024-04-24 17:30:57'),
(122, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA UNIDAD/ÁREA', 'id: 1<br/>nombre: AREA #1<br/>descripcion: DESC. #1<br/>user_id: 7<br/>ubicacion: UBICACION #1<br/>unidad: UNIDAD #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-04-24 13:30:57<br/>', 'id: 1<br/>nombre: AREA #1<br/>descripcion: DESC. #1<br/>user_id: 2<br/>ubicacion: UBICACION #1<br/>unidad: UNIDAD #1<br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 17:35:08<br/>updated_at: 2024-04-24 13:31:06<br/>', 'UNIDADES Y ÁREAS', '2024-04-24', '13:31:06', '2024-04-24 17:31:06', '2024-04-24 17:31:06'),
(123, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>responsable_id: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>tecnico_id: 3<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: PREVENTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: 2024-02-08<br/>biometrico_id: 1<br/>repuestos: 1,2<br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-04-06 12:23:59<br/>', 'id: 1<br/>codigo: SOL.MAT.1<br/>nro: 1<br/>responsable_id: 2<br/>nombre_responsable: JUAN PERES<br/>ci_responsable: 1234<br/>tecnico_id: 3<br/>nombre_tecnico: FERNANDO TAPIA<br/>ci_tecnico: 4444<br/>tipo_mantenimiento: PREVENTIVO<br/>motivo_mantenimiento: MOTIVO MANTENIMIENTO #1<br/>diagnostico: DIAGNOSTICO #1<br/>otros: OTROS #1<br/>fecha_solicitud: 2024-02-07<br/>fecha_entrega: 2024-02-08<br/>biometrico_id: 1<br/>repuestos: <br/>fecha_registro: 2024-02-07<br/>created_at: 2024-02-07 19:57:02<br/>updated_at: 2024-04-24 13:33:07<br/>', 'REPUESTOS', '2024-04-24', '13:33:07', '2024-04-24 17:33:07', '2024-04-24 17:33:07'),
(124, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 5<br/>codigo: SOL.MAT.5<br/>nro: 5<br/>responsable_id: 5<br/>nombre_responsable: <br/>ci_responsable: <br/>tecnico_id: 3<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO #5<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-04-24<br/>fecha_entrega: <br/>biometrico_id: 3<br/>repuestos: <br/>fecha_registro: 2024-04-24<br/>created_at: 2024-04-24 13:33:39<br/>updated_at: 2024-04-24 13:33:39<br/>', NULL, 'REPUESTOS', '2024-04-24', '13:33:39', '2024-04-24 17:33:39', '2024-04-24 17:33:39'),
(125, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-04-06 12:00:05<br/>', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: COD-0002<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-04-24 13:38:08<br/>', 'BIOMETRICOS', '2024-04-24', '13:38:08', '2024-04-24 17:38:08', '2024-04-24 17:38:08'),
(126, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:04:18<br/>', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 777744444444<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:43:47<br/>', 'USUARIOS', '2024-04-24', '13:43:47', '2024-04-24 17:43:47', '2024-04-24 17:43:47'),
(127, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 777744444444<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:43:47<br/>', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:43:56<br/>', 'USUARIOS', '2024-04-24', '13:43:56', '2024-04-24 17:43:56', '2024-04-24 17:43:56'),
(128, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:43:56<br/>', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:43:56<br/>', 'USUARIOS', '2024-04-24', '22:35:46', '2024-04-25 02:35:46', '2024-04-25 02:35:46'),
(129, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 13:43:56<br/>', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZS<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 22:35:58<br/>', 'USUARIOS', '2024-04-24', '22:35:58', '2024-04-25 02:35:58', '2024-04-25 02:35:58'),
(130, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZS<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 22:35:58<br/>', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 22:36:03<br/>', 'USUARIOS', '2024-04-24', '22:36:03', '2024-04-25 02:36:03', '2024-04-25 02:36:03');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(131, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 22:36:03<br/>', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 0<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 22:36:08<br/>', 'USUARIOS', '2024-04-24', '22:36:08', '2024-04-25 02:36:08', '2024-04-25 02:36:08'),
(132, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 0<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 22:36:08<br/>', 'id: 7<br/>usuario: GCORTEZ<br/>password: $2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S<br/>nombre: GEOVANA<br/>paterno: CORTEZ<br/>materno: <br/>ci: 7777<br/>ci_exp: CB<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6565656<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 13:04:18<br/>updated_at: 2024-04-24 22:36:11<br/>', 'USUARIOS', '2024-04-24', '22:36:11', '2024-04-25 02:36:11', '2024-04-25 02:36:11'),
(133, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 8<br/>usuario: MALCANTARA<br/>password: $2y$12$rzSJ5q.10.e6NPATwvfYcePwTzM/NBlHyIkvVRhzwGxGdOtHin2r6<br/>nombre: MARCOS<br/>paterno: ALCANTARA<br/>materno: <br/>ci: 8888<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: MARCOS@GMAIL.COM<br/>fono: 77777777<br/>tipo: JEFE DE ÁREA<br/>foto: <br/>item: <br/>acceso: 1<br/>fecha_registro: 2024-04-24 00:00:00<br/>created_at: 2024-04-24 22:36:34<br/>updated_at: 2024-04-24 22:36:34<br/>', NULL, 'USUARIOS', '2024-04-24', '22:36:34', '2024-04-25 02:36:34', '2024-04-25 02:36:34'),
(134, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN DOCUMENTO', 'id: 1<br/>descripcion: DOCUMENTOS #1<br/>created_at: 2024-04-06 14:53:15<br/>updated_at: 2024-04-06 14:53:15<br/>', 'id: 1<br/>descripcion: DOCUMENTOS #1S<br/>created_at: 2024-04-06 14:53:15<br/>updated_at: 2024-04-24 23:03:45<br/>', 'DOCUMENTOS', '2024-04-24', '23:03:45', '2024-04-25 03:03:45', '2024-04-25 03:03:45'),
(135, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN DOCUMENTO', 'id: 1<br/>descripcion: DOCUMENTOS #1S<br/>created_at: 2024-04-06 14:53:15<br/>updated_at: 2024-04-24 23:03:45<br/>', 'id: 1<br/>descripcion: DOCUMENTOS #1<br/>created_at: 2024-04-06 14:53:15<br/>updated_at: 2024-04-24 23:03:50<br/>', 'DOCUMENTOS', '2024-04-24', '23:03:50', '2024-04-25 03:03:50', '2024-04-25 03:03:50'),
(136, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN SERVICIO', 'id: 3<br/>solicitud_mantenimiento_id: 5<br/>fecha_entrega: 2024-04-30<br/>procedimientos: PROCEDIMIENTOS<br/>observaciones: OBS<br/>recomendaciones: RECOMENDACIONES<br/>diagnostico_previo: <br/>estado_equipo: <br/>trabajo_realizado: TRABAJO REALIZADO<br/>capacitacion: NO<br/>descripcion: <br/>fecha_ini: <br/>fecha_fin: <br/>fecha_registro: 2024-04-27<br/>created_at: 2024-04-27 21:26:40<br/>updated_at: 2024-04-27 21:26:40<br/>', NULL, 'SERVICIOS', '2024-04-27', '21:26:40', '2024-04-28 01:26:40', '2024-04-28 01:26:40'),
(137, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 4<br/>nombre: EQUIPO #4<br/>estado: BUENO<br/>marca: MARCA #4<br/>serie: S000093D<br/>modelo: <br/>fecha_ingreso: 2024-04-22<br/>garantia: NO<br/>cod_hdn: HDN<br/>manual_usuario: 1713976798_14.xlsx<br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: <br/>foto: <br/>accesorios: <br/>estado_equipo: <br/>fecha_registro: 2024-04-22<br/>created_at: 2024-04-22 16:47:18<br/>updated_at: 2024-04-24 12:39:58<br/>', 'id: 4<br/>nombre: EQUIPO #4<br/>estado: BUENO<br/>marca: MARCA #4<br/>serie: S000093D<br/>modelo: <br/>fecha_ingreso: 2024-04-22<br/>garantia: NO<br/>cod_hdn: HDN<br/>manual_usuario: 1713976798_14.xlsx<br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: <br/>foto: <br/>accesorios: <br/>estado_equipo: ACTIVO<br/>fecha_registro: 2024-04-22<br/>created_at: 2024-04-22 16:47:18<br/>updated_at: 2024-05-02 12:58:30<br/>', 'BIOMETRICOS', '2024-05-02', '12:58:30', '2024-05-02 16:58:30', '2024-05-02 16:58:30'),
(138, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: COD-0002<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>accesorios: <br/>estado_equipo: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-04-24 13:38:08<br/>', 'id: 3<br/>nombre: EQUIPO #3<br/>estado: REGULAR<br/>marca: MARCA-002<br/>serie: SER-003<br/>modelo: MOD-003<br/>fecha_ingreso: 2024-02-08<br/>garantia: SI<br/>cod_hdn: COD-0002<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: 3<br/>foto: <br/>accesorios: <br/>estado_equipo: ACTIVO<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 20:20:37<br/>updated_at: 2024-05-02 12:58:36<br/>', 'BIOMETRICOS', '2024-05-02', '12:58:36', '2024-05-02 16:58:36', '2024-05-02 16:58:36'),
(139, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: <br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>accesorios: <br/>estado_equipo: <br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-04-06 12:39:40<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>estado: BUENO<br/>marca: <br/>serie: <br/>modelo: <br/>fecha_ingreso: 2024-02-08<br/>garantia: NO<br/>cod_hdn: COD-002<br/>manual_usuario: <br/>manual_servicio: <br/>unidad_area_id: 2<br/>empresa_id: <br/>foto: <br/>accesorios: <br/>estado_equipo: INACTIVO<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 11:26:52<br/>updated_at: 2024-05-02 12:58:50<br/>', 'BIOMETRICOS', '2024-05-02', '12:58:50', '2024-05-02 16:58:50', '2024-05-02 16:58:50'),
(140, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN BIOMETRICO', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: SI<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>accesorios: <br/>estado_equipo: <br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-04-06 11:59:56<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>estado: REGULAR<br/>marca: M0001<br/>serie: S-001<br/>modelo: M-001<br/>fecha_ingreso: 2024-01-01<br/>garantia: SI<br/>cod_hdn: HDN-001<br/>manual_usuario: 1712417405_11.pdf<br/>manual_servicio: 1712417417_21.pdf<br/>unidad_area_id: 1<br/>empresa_id: 1<br/>foto: 1707238084_1.png<br/>accesorios: <br/>estado_equipo: ACTIVO<br/>fecha_registro: 2024-02-06<br/>created_at: 2024-02-06 12:48:04<br/>updated_at: 2024-05-02 12:58:54<br/>', 'BIOMETRICOS', '2024-05-02', '12:58:54', '2024-05-02 16:58:54', '2024-05-02 16:58:54'),
(141, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'SERVICIOS', '2024-05-02', '13:08:35', '2024-05-02 17:08:35', '2024-05-02 17:08:35'),
(142, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'SERVICIOS', '2024-05-02', '13:09:49', '2024-05-02 17:09:49', '2024-05-02 17:09:49'),
(143, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'SERVICIOS', '2024-05-02', '13:10:34', '2024-05-02 17:10:34', '2024-05-02 17:10:34'),
(144, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-02-08 15:36:00<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: 1,2<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-05-02 13:10:53<br/>', 'SERVICIOS', '2024-05-02', '13:10:53', '2024-05-02 17:10:53', '2024-05-02 17:10:53'),
(145, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 1<br/>nombre: REPUESTO #1<br/>unidad_area_id: 0<br/>created_at: 2024-02-06 12:59:34<br/>updated_at: 2024-02-06 12:59:34<br/>', 'id: 1<br/>nombre: REPUESTO #1<br/>unidad_area_id: 1<br/>created_at: 2024-02-06 12:59:34<br/>updated_at: 2024-05-02 13:25:36<br/>', 'REPUESTOS', '2024-05-02', '13:25:36', '2024-05-02 17:25:36', '2024-05-02 17:25:36'),
(146, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN REPUESTO', 'id: 2<br/>nombre: REPUESTO #2<br/>unidad_area_id: 0<br/>created_at: 2024-02-06 12:59:50<br/>updated_at: 2024-02-06 12:59:50<br/>', 'id: 2<br/>nombre: REPUESTO #2<br/>unidad_area_id: 2<br/>created_at: 2024-02-06 12:59:50<br/>updated_at: 2024-05-02 13:25:40<br/>', 'REPUESTOS', '2024-05-02', '13:25:40', '2024-05-02 17:25:40', '2024-05-02 17:25:40'),
(147, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 3<br/>nombre: REPUESTO #3<br/>unidad_area_id: 1<br/>created_at: 2024-05-02 13:25:46<br/>updated_at: 2024-05-02 13:25:46<br/>', NULL, 'REPUESTOS', '2024-05-02', '13:25:46', '2024-05-02 17:25:46', '2024-05-02 17:25:46'),
(148, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 4<br/>nombre: REPUESTO #4<br/>unidad_area_id: 1<br/>created_at: 2024-05-02 13:25:51<br/>updated_at: 2024-05-02 13:25:51<br/>', NULL, 'REPUESTOS', '2024-05-02', '13:25:51', '2024-05-02 17:25:51', '2024-05-02 17:25:51'),
(149, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN REPUESTO', 'id: 5<br/>nombre: REPUESTO #5<br/>unidad_area_id: 2<br/>created_at: 2024-05-02 13:26:03<br/>updated_at: 2024-05-02 13:26:03<br/>', NULL, 'REPUESTOS', '2024-05-02', '13:26:03', '2024-05-02 17:26:03', '2024-05-02 17:26:03'),
(150, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: 1,2<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-05-02 13:10:53<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-05-02 13:28:22<br/>', 'SERVICIOS', '2024-05-02', '13:28:22', '2024-05-02 17:28:22', '2024-05-02 17:28:22'),
(151, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-05-02 13:28:22<br/>', 'id: 1<br/>solicitud_mantenimiento_id: 1<br/>fecha_entrega: 2024-02-08<br/>procedimientos: PROCEDIMIENTOS SERVICIO #1<br/>observaciones: OBSERVACIONES SERVCIO #1<br/>recomendaciones: RECOMENDACIONE SERVICIO #1<br/>diagnostico_previo: DIAGNOSTICO PREVIO #1<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO SERVICIO #1<br/>capacitacion: SI<br/>descripcion: DESC. CAPACITACION<br/>repuestos: 1,3<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-01-31<br/>fecha_registro: 2024-02-08<br/>created_at: 2024-02-08 15:00:00<br/>updated_at: 2024-05-02 13:33:06<br/>', 'SERVICIOS', '2024-05-02', '13:33:06', '2024-05-02 17:33:06', '2024-05-02 17:33:06'),
(152, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN BIOMETRICO', 'id: 4<br/>nombre: EQUIPO #4<br/>estado: BUENO<br/>marca: MARCA #4<br/>serie: S000093D<br/>modelo: <br/>fecha_ingreso: 2024-04-22<br/>garantia: NO<br/>cod_hdn: HDN<br/>manual_usuario: 1713976798_14.xlsx<br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: <br/>foto: <br/>accesorios: <br/>estado_equipo: ACTIVO<br/>fecha_registro: 2024-04-22<br/>status: 1<br/>created_at: 2024-04-22 16:47:18<br/>updated_at: 2024-05-02 12:58:30<br/>', NULL, 'BIOMETRICOS', '2024-05-02', '14:24:27', '2024-05-02 18:24:27', '2024-05-02 18:24:27'),
(153, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN BIOMETRICO', 'id: 4<br/>nombre: EQUIPO #4<br/>estado: BUENO<br/>marca: MARCA #4<br/>serie: S000093D<br/>modelo: <br/>fecha_ingreso: 2024-04-22<br/>garantia: NO<br/>cod_hdn: HDN<br/>manual_usuario: 1713976798_14.xlsx<br/>manual_servicio: <br/>unidad_area_id: 1<br/>empresa_id: <br/>foto: <br/>accesorios: <br/>estado_equipo: ACTIVO<br/>fecha_registro: 2024-04-22<br/>status: 1<br/>created_at: 2024-04-22 16:47:18<br/>updated_at: 2024-05-02 14:24:27<br/>', NULL, 'BIOMETRICOS', '2024-05-02', '14:24:39', '2024-05-02 18:24:39', '2024-05-02 18:24:39'),
(154, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA UNIDAD/ÁREA', 'id: 4<br/>nombre: AREA #4<br/>descripcion: <br/>user_id: 8<br/>ubicacion: <br/>unidad: <br/>fecha_registro: 2024-05-02<br/>status: <br/>created_at: 2024-05-02 15:30:35<br/>updated_at: 2024-05-02 15:30:35<br/>', NULL, 'UNIDADES Y ÁREAS', '2024-05-02', '15:30:35', '2024-05-02 19:30:35', '2024-05-02 19:30:35'),
(155, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN SOLICITUD DE MANTENIMIENTO', 'id: 6<br/>codigo: SOL.MAT.6<br/>nro: 6<br/>responsable_id: 2<br/>nombre_responsable: <br/>ci_responsable: <br/>tecnico_id: 3<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: <br/>motivo_mantenimiento: MOTIVO NUEVO<br/>diagnostico: <br/>otros: OTROS<br/>fecha_solicitud: 2024-05-28<br/>fecha_entrega: <br/>biometrico_id: 1<br/>repuestos: <br/>fecha_registro: 2024-05-28<br/>status: <br/>created_at: 2024-05-28 10:46:27<br/>updated_at: 2024-05-28 10:46:27<br/>', NULL, 'SOLICITUD DE MANTENIMIENTOS', '2024-05-28', '10:46:27', '2024-05-28 14:46:27', '2024-05-28 14:46:27'),
(156, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN SERVICIO', 'id: 4<br/>solicitud_mantenimiento_id: 6<br/>fecha_entrega: 2024-05-28<br/>procedimientos: PROCEDIMIENTOS<br/>observaciones: OBS.<br/>recomendaciones: RECOMENDACIONES<br/>diagnostico_previo: DIAGNOSTICO PREVIO<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO<br/>capacitacion: SI<br/>descripcion: DESCRIPCION CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-06-06<br/>fecha_registro: 2024-05-28<br/>status: <br/>created_at: 2024-05-28 10:47:08<br/>updated_at: 2024-05-28 10:47:08<br/>', NULL, 'SERVICIOS', '2024-05-28', '10:47:08', '2024-05-28 14:47:08', '2024-05-28 14:47:08'),
(157, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN SERVICIO', 'id: 4<br/>solicitud_mantenimiento_id: 6<br/>fecha_entrega: 2024-05-28<br/>procedimientos: PROCEDIMIENTOS<br/>observaciones: OBS.<br/>recomendaciones: RECOMENDACIONES<br/>diagnostico_previo: DIAGNOSTICO PREVIO<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO<br/>capacitacion: SI<br/>descripcion: DESCRIPCION CAPACITACION<br/>repuestos: <br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-06-06<br/>fecha_registro: 2024-05-28<br/>status: 1<br/>created_at: 2024-05-28 10:47:08<br/>updated_at: 2024-05-28 10:47:08<br/>', 'id: 4<br/>solicitud_mantenimiento_id: 6<br/>fecha_entrega: 2024-05-28<br/>procedimientos: PROCEDIMIENTOS<br/>observaciones: OBS.<br/>recomendaciones: RECOMENDACIONES<br/>diagnostico_previo: DIAGNOSTICO PREVIO<br/>estado_equipo: ESTADO EQUIPO<br/>trabajo_realizado: TRABAJO REALIZADO<br/>capacitacion: SI<br/>descripcion: DESCRIPCION CAPACITACION<br/>repuestos: 1,3<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-06-06<br/>fecha_registro: 2024-05-28<br/>status: 1<br/>created_at: 2024-05-28 10:47:08<br/>updated_at: 2024-05-28 10:47:17<br/>', 'SERVICIOS', '2024-05-28', '10:47:17', '2024-05-28 14:47:17', '2024-05-28 14:47:17'),
(158, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 1<br/>nombre: EMPRESA #1<br/>nit: 111111<br/>fono: 7777777<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-09-03<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS<br/>pais: BOLIVIA<br/>logo: 1707171817_1.jpg<br/>fecha_registro: 2024-02-05<br/>status: 1<br/>created_at: 2024-02-05 18:23:37<br/>updated_at: 2024-04-06 11:57:31<br/>', 'id: 1<br/>nombre: EMPRESA #1<br/>nit: 111111<br/>fono: 7777777<br/>fecha_ini: 2024-01-01<br/>fecha_fin: 2024-09-03<br/>correo: EMPRESA1@GMAIL.COM<br/>dir: LOS OLIVOS<br/>pais: BOLIVIA<br/>logo: 1718392802_1.png<br/>fecha_registro: 2024-02-05<br/>status: 1<br/>created_at: 2024-02-05 18:23:37<br/>updated_at: 2024-06-14 15:20:02<br/>', 'EMPRESAS', '2024-06-14', '15:20:02', '2024-06-14 19:20:02', '2024-06-14 19:20:02'),
(159, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA EMPRESA', 'id: 5<br/>nombre: EMPRESA #5<br/>nit: 123123<br/>fono: 545454545<br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>pais: <br/>logo: 1718392825_5.png<br/>fecha_registro: 2024-06-14<br/>status: <br/>created_at: 2024-06-14 15:20:25<br/>updated_at: 2024-06-14 15:20:25<br/>', NULL, 'EMPRESAS', '2024-06-14', '15:20:25', '2024-06-14 19:20:25', '2024-06-14 19:20:25'),
(160, 3, 'CREACIÓN', 'EL USUARIO  REGISTRO UN SOLICITUD DE MANTENIMIENTO', 'id: 7<br/>codigo: SOL.MAT.7<br/>nro: 7<br/>responsable_id: 8<br/>nombre_responsable: <br/>ci_responsable: <br/>tecnico_id: 3<br/>nombre_tecnico: <br/>ci_tecnico: <br/>tipo_mantenimiento: CORRECTIVO<br/>motivo_mantenimiento: MOTIVO NUEVO MANTENIMIENTO<br/>diagnostico: <br/>otros: <br/>fecha_solicitud: 2024-06-14<br/>fecha_entrega: <br/>biometrico_id: 3<br/>repuestos: <br/>fecha_registro: 2024-06-14<br/>status: <br/>created_at: 2024-06-14 15:50:47<br/>updated_at: 2024-06-14 15:50:47<br/>', NULL, 'SOLICITUD DE MANTENIMIENTOS', '2024-06-14', '15:50:47', '2024-06-14 19:50:47', '2024-06-14 19:50:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucions`
--

CREATE TABLE `institucions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `historia` text COLLATE utf8mb4_unicode_ci,
  `mision` text COLLATE utf8mb4_unicode_ci,
  `vision` text COLLATE utf8mb4_unicode_ci,
  `objetivo` text COLLATE utf8mb4_unicode_ci,
  `nombre_director` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto_director` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_subdirector` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_subdirector` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacion_google` text COLLATE utf8mb4_unicode_ci,
  `img_organigrama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `captcha_local` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `captcha_servidor` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `institucions`
--

INSERT INTO `institucions` (`id`, `nombre`, `nombre_sistema`, `nit`, `historia`, `mision`, `vision`, `objetivo`, `nombre_director`, `foto_director`, `nombre_subdirector`, `foto_subdirector`, `fono1`, `fono2`, `correo1`, `correo2`, `facebook`, `youtube`, `twitter`, `dir`, `ubicacion_google`, `img_organigrama`, `logo`, `logo2`, `captcha_local`, `captcha_servidor`, `created_at`, `updated_at`) VALUES
(1, 'INSTITUCIÓN S.A.', 'SISTEMA SISHN', '111111111', 'LOREM IPSUM ES SIMPLEMENTE EL TEXTO DE RELLENO DE LAS IMPRENTAS Y ARCHIVOS DE TEXTO. LOREM IPSUM HA SIDO EL TEXTO DE RELLENO ESTÁNDAR DE LAS INDUSTRIAS DESDE EL AÑO 1500, CUANDO UN IMPRESOR (N. DEL T. PERSONA QUE SE DEDICA A LA IMPRENTA) DESCONOCIDO USÓ UNA GALERÍA DE TEXTOS Y LOS MEZCLÓ DE TAL MANERA QUE LOGRÓ HACER UN LIBRO DE TEXTOS ESPECIMEN. NO SÓLO SOBREVIVIÓ 500 AÑOS, SINO QUE TAMBIEN INGRESÓ COMO TEXTO DE RELLENO EN DOCUMENTOS ELECTRÓNICOS,', 'LOREM IPSUM ES SIMPLEMENTE EL TEXTO DE RELLENO DE LAS IMPRENTAS Y ARCHIVOS DE TEXTO. LOREM IPSUM HA SIDO EL TEXTO DE RELLENO ESTÁNDAR DE LAS INDUSTRIAS DESDE EL AÑO 1500, CUANDO UN IMPRESOR (N. DEL T. PERSONA QUE SE DEDICA A LA IMPRENTA) DESCONOCIDO USÓ UNA GALERÍA DE TEXTOS Y LOS MEZCLÓ DE TAL MANERA QUE LOGRÓ HACER UN LIBRO DE TEXTOS ESPECIMEN. NO SÓLO SOBREVIVIÓ 500 AÑOS, SINO QUE TAMBIEN INGRESÓ COMO TEXTO DE RELLENO EN DOCUMENTOS ELECTRÓNICOS', 'VISION: LOREM IPSUM ES SIMPLEMENTE EL TEXTO DE RELLENO DE LAS IMPRENTAS Y ARCHIVOS DE TEXTO. LOREM IPSUM HA SIDO EL TEXTO DE RELLENO ESTÁNDAR DE LAS INDUSTRIAS DESDE EL AÑO 1500, CUANDO UN IMPRESOR (N. DEL T. PERSONA QUE SE DEDICA A LA IMPRENTA)', 'LOREM IPSUM ES SIMPLEMENTE EL TEXTO DE RELLENO DE LAS IMPRENTAS Y ARCHIVOS DE TEXTO. LOREM IPSUM HA SIDO EL TEXTO DE RELLENO ESTÁNDAR DE LAS INDUSTRIAS DESDE EL AÑO 1500, CUANDO UN IMPRESOR (N. DEL T. PERSONA QUE SE DEDICA A LA IMPRENTA) DESCONOCIDO USÓ UNA GALERÍA DE TEXTOS Y LOS MEZCLÓ DE TAL MANERA QUE LOGRÓ HACER UN LIBRO DE TEXTOS ESPECIMEN. NO SÓLO SOBREVIVIÓ 500 AÑOS, SINO QUE TAMBIEN INGRESÓ COMO TEXTO DE RELLENO EN DOCUMENTOS ELECTRÓNICOS', 'JUAN PERES', '1714685484d_1.png', 'JOSE PAREDES', '1714685484sd_1.png', '77575383', '666666', 'CORREO1@GMAIL.COM', 'CORREO2@GMAIL.COM', 'HTTPS://FACEBOOK.COM', 'HTTPS://YOUTUBE.COM', 'HTTPS://TWITTER.COM', 'LOS OLIVOS', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d12143.389812786238!2d-68.08918332465664!3d-16.52975316867156!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.527973505058714!2d-68.08870645756463!5e0!3m2!1ses-419!2sbo!4v1706929714970!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', '1706930367_1.WEBP', '1714681812_1.jpg', '1718393475_1.PNG', '6LeUmvkpAAAAAA7odjqGgzzLf1poEIqfN-a1wEVA', '6LeUmvkpAAAAAEO5gThRwL4yqJMawpJxkIYpiE1s', NULL, '2024-06-14 19:40:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2024_01_31_165641_create_institucions_table', 1),
(4, '2024_02_02_205431_create_historial_accions_table', 1),
(9, '2024_02_02_210419_create_unidad_areas_table', 2),
(10, '2024_02_02_210429_create_empresas_table', 2),
(11, '2024_02_02_210509_create_biometricos_table', 2),
(12, '2024_02_02_210529_create_repuestos_table', 2),
(13, '2024_02_02_210530_create_solicitud_mantenimientos_table', 2),
(14, '2024_02_02_211435_create_servicios_table', 2),
(16, '2024_02_07_112134_create_cronogramas_table', 3),
(17, '2024_04_06_142135_create_documentos_table', 4),
(18, '2024_04_06_142203_create_documento_archivos_table', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestos`
--

CREATE TABLE `repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidad_area_id` bigint UNSIGNED NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `repuestos`
--

INSERT INTO `repuestos` (`id`, `nombre`, `unidad_area_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'REPUESTO #1', 1, 1, '2024-02-06 16:59:34', '2024-05-02 17:25:36'),
(2, 'REPUESTO #2', 2, 1, '2024-02-06 16:59:50', '2024-05-02 17:25:40'),
(3, 'REPUESTO #3', 1, 1, '2024-05-02 17:25:46', '2024-05-02 17:25:46'),
(4, 'REPUESTO #4', 1, 1, '2024-05-02 17:25:51', '2024-05-02 17:25:51'),
(5, 'REPUESTO #5', 2, 1, '2024-05-02 17:26:03', '2024-05-02 17:26:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` bigint UNSIGNED NOT NULL,
  `solicitud_mantenimiento_id` bigint UNSIGNED NOT NULL,
  `fecha_entrega` date NOT NULL,
  `procedimientos` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `recomendaciones` text COLLATE utf8mb4_unicode_ci,
  `diagnostico_previo` text COLLATE utf8mb4_unicode_ci,
  `estado_equipo` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trabajo_realizado` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacitacion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `repuestos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_ini` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `solicitud_mantenimiento_id`, `fecha_entrega`, `procedimientos`, `observaciones`, `recomendaciones`, `diagnostico_previo`, `estado_equipo`, `trabajo_realizado`, `capacitacion`, `descripcion`, `repuestos`, `fecha_ini`, `fecha_fin`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-02-08', 'PROCEDIMIENTOS SERVICIO #1', 'OBSERVACIONES SERVCIO #1', 'RECOMENDACIONE SERVICIO #1', 'DIAGNOSTICO PREVIO #1', 'ESTADO EQUIPO', 'TRABAJO REALIZADO SERVICIO #1', 'SI', 'DESC. CAPACITACION', '1,3', '2024-01-01', '2024-01-31', '2024-02-08', 1, '2024-02-08 19:00:00', '2024-05-02 17:33:06'),
(2, 2, '2024-02-09', 'PROCEDIMIENTOS #2', 'OBSERVACIONES #2', '', '', '', 'TRABAJO REALIZADO #2', 'NO', '', '', NULL, NULL, '2024-02-09', 1, '2024-02-09 18:35:42', '2024-02-09 18:35:42'),
(3, 5, '2024-04-30', 'PROCEDIMIENTOS', 'OBS', 'RECOMENDACIONES', '', '', 'TRABAJO REALIZADO', 'NO', '', '', NULL, NULL, '2024-04-27', 1, '2024-04-28 01:26:40', '2024-04-28 01:26:40'),
(4, 6, '2024-05-28', 'PROCEDIMIENTOS', 'OBS.', 'RECOMENDACIONES', 'DIAGNOSTICO PREVIO', 'ESTADO EQUIPO', 'TRABAJO REALIZADO', 'SI', 'DESCRIPCION CAPACITACION', '1,3', '2024-01-01', '2024-06-06', '2024-05-28', 1, '2024-05-28 14:47:08', '2024-05-28 14:47:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_mantenimientos`
--

CREATE TABLE `solicitud_mantenimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro` bigint UNSIGNED NOT NULL,
  `responsable_id` bigint UNSIGNED DEFAULT NULL,
  `nombre_responsable` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci_responsable` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tecnico_id` bigint UNSIGNED DEFAULT NULL,
  `nombre_tecnico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci_tecnico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_mantenimiento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `motivo_mantenimiento` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `diagnostico` text COLLATE utf8mb4_unicode_ci,
  `otros` text COLLATE utf8mb4_unicode_ci,
  `fecha_solicitud` date NOT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `biometrico_id` bigint UNSIGNED NOT NULL,
  `repuestos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `solicitud_mantenimientos`
--

INSERT INTO `solicitud_mantenimientos` (`id`, `codigo`, `nro`, `responsable_id`, `nombre_responsable`, `ci_responsable`, `tecnico_id`, `nombre_tecnico`, `ci_tecnico`, `tipo_mantenimiento`, `motivo_mantenimiento`, `diagnostico`, `otros`, `fecha_solicitud`, `fecha_entrega`, `biometrico_id`, `repuestos`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'SOL.MAT.1', 1, 2, 'JUAN PERES', '1234', 3, 'FERNANDO TAPIA', '4444', 'PREVENTIVO', 'MOTIVO MANTENIMIENTO #1', 'DIAGNOSTICO #1', 'OTROS #1', '2024-02-07', '2024-02-08', 1, '', '2024-02-07', 1, '2024-02-07 23:57:02', '2024-04-24 17:33:07'),
(2, 'SOL.MAT.2', 2, 5, 'JUAN PERES', '2222', 3, '', '', 'CORRECTIVO', 'MOTIVO MANTENIMIENTO', '', '', '2024-02-08', '2024-02-09', 2, '1,2', '2024-02-08', 1, '2024-02-08 15:30:04', '2024-04-06 16:26:10'),
(3, 'SOL.MAT.3', 3, 4, 'JUAN PERES', '1234', 3, 'FERNANDO CORTEZ', '3333', '', 'MOTIVO MANTENIMIENTO', '', '', '2024-02-08', NULL, 3, '2', '2024-02-08', 1, '2024-02-09 00:21:16', '2024-04-06 16:24:14'),
(4, 'SOL.MAT.4', 4, 2, '', '', 3, '', '', 'CORRECTIVO', 'MOTIVO MANT. #4', 'DIAGNOSTICO', '', '2024-04-06', NULL, 2, '1', '2024-04-06', 1, '2024-04-06 16:27:33', '2024-04-06 16:28:01'),
(5, 'SOL.MAT.5', 5, 5, '', '', 3, '', '', '', 'MOTIVO #5', '', '', '2024-04-24', '2024-04-30', 3, '', '2024-04-24', 1, '2024-04-24 17:33:39', '2024-04-28 01:26:40'),
(6, 'SOL.MAT.6', 6, 2, '', '', 3, '', '', '', 'MOTIVO NUEVO', NULL, 'OTROS', '2024-05-28', '2024-05-28', 1, NULL, '2024-05-28', 1, '2024-05-28 14:46:27', '2024-05-28 14:47:08'),
(7, 'SOL.MAT.7', 7, 8, '', '', 3, '', '', 'CORRECTIVO', 'MOTIVO NUEVO MANTENIMIENTO', NULL, '', '2024-06-14', NULL, 3, NULL, '2024-06-14', 1, '2024-06-14 19:50:47', '2024-06-14 19:50:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_areas`
--

CREATE TABLE `unidad_areas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidad_areas`
--

INSERT INTO `unidad_areas` (`id`, `nombre`, `descripcion`, `user_id`, `ubicacion`, `unidad`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'AREA #1', 'DESC. #1', 2, 'UBICACION #1', 'UNIDAD #1', '2024-02-05', 1, '2024-02-05 21:35:08', '2024-04-24 17:31:06'),
(2, 'AREA #2', 'DESC', 4, 'UBICACION AREA #2', 'UNIDAD #2', '2024-02-08', 1, '2024-02-08 15:26:35', '2024-04-06 15:53:43'),
(3, 'AREA #3', '', 5, 'UBICACION AREA #3', 'UNIDAD #2', '2024-04-06', 1, '2024-04-06 15:54:33', '2024-04-06 15:54:33'),
(4, 'AREA #4', '', 8, '', '', '2024-05-02', 1, '2024-05-02 19:30:35', '2024-05-02 19:30:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acceso` int NOT NULL DEFAULT '1',
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `email`, `fono`, `tipo`, `foto`, `item`, `acceso`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 'admin', NULL, NULL, '0', '', '', 'admin@gmail.com', '', 'ADMINISTRADOR', NULL, NULL, 1, '2024-01-31', 1, NULL, '2024-02-02 18:13:58'),
(2, 'JPERES', '$2y$12$JdiMKhhseUf5McMcqY.ED.pY0.r2DSqvMS9PAv1A7bsFSmO1UGWBu', 'JUAN', 'PERES', 'MAMANI', '1234', 'LP', 'LOS OLIVOS', 'JUAN@GMAIL.COM', '777777', 'JEFE DE ÁREA', '1707167967_JPERES.jpg', '111111', 1, '2024-02-05', 1, '2024-02-05 21:19:27', '2024-04-06 15:43:03'),
(3, 'FPAREDES', '$2y$12$jQnFeAHVj3iptVZQKnFPlebgMqFp9IccVui5FS6YGpjz9KLSvqVl.', 'FERNANDO', 'PAREDES', 'MAMANI', '2222', 'LP', 'LOS OLIVOS', '', '777777', 'TÉCNICO', NULL, NULL, 1, '2024-02-08', 1, '2024-02-08 15:16:00', '2024-02-08 15:16:01'),
(4, 'MMAMANI', '$2y$12$VJ37jS9TwD/ep6JTtJ0nnuKpHAgcgP.nJzHka.8knnKOiENrhp3Sq', 'MARIA', 'MAMANI', 'MAMANI', '3333', 'CB', 'LOS OLIVOS', '', '77777', 'JEFE DE ÁREA', NULL, NULL, 1, '2024-02-08', 1, '2024-02-08 15:26:19', '2024-02-08 15:26:19'),
(5, 'AMAMANI', '$2y$12$DbDh0axGVKOwwYdPlYUD4.PLEcqupIdP17jti8Kp0edHB3xpZjJcG', 'ALEXIS', 'MAMANI', 'MAMANI', '5555', 'LP', 'LOS OLIVOS', 'ALEX@GMAIL.COM', '77777', 'JEFE DE ÁREA', NULL, NULL, 1, '2024-02-20', 1, '2024-02-20 19:49:05', '2024-02-20 19:49:05'),
(6, 'RCONTRERAS', '$2y$12$pgYF5E0.wogTKnvRE7x7A.MtYqHOuRi7By431ljqeW5kseTABqc5W', 'RAMIRO', 'CONTRERAS', '', '6666', 'LP', 'LOS OLIVOS', '', '77777777', 'DIRECTOR', NULL, 'I-003333', 1, '2024-04-06', 1, '2024-04-06 15:44:01', '2024-04-06 15:44:01'),
(7, 'GCORTEZ', '$2y$12$gHpKic4izSCOCjoXz5KT6OA..fghymmKqi7SuG2dUbTvdQcunpO2S', 'GEOVANA', 'CORTEZ', '', '7777', 'CB', 'LOS OLIVOS', '', '6565656', 'JEFE DE ÁREA', NULL, '', 1, '2024-04-24', 1, '2024-04-24 17:04:18', '2024-04-25 02:36:11'),
(8, 'MALCANTARA', '$2y$12$rzSJ5q.10.e6NPATwvfYcePwTzM/NBlHyIkvVRhzwGxGdOtHin2r6', 'MARCOS', 'ALCANTARA', '', '8888', 'LP', 'LOS OLIVOS', 'MARCOS@GMAIL.COM', '77777777', 'JEFE DE ÁREA', NULL, '', 1, '2024-04-24', 1, '2024-04-25 02:36:34', '2024-04-25 02:36:34');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `biometricos`
--
ALTER TABLE `biometricos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `biometricos_unidad_area_id_foreign` (`unidad_area_id`),
  ADD KEY `biometricos_empresa_id_foreign` (`empresa_id`);

--
-- Indices de la tabla `cronogramas`
--
ALTER TABLE `cronogramas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cronogramas_solicitud_mantenimiento_id_foreign` (`solicitud_mantenimiento_id`),
  ADD KEY `cronogramas_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `documento_archivos`
--
ALTER TABLE `documento_archivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documento_archivos_documento_id_foreign` (`documento_id`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `institucions`
--
ALTER TABLE `institucions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servicios_solicitud_mantenimiento_id_foreign` (`solicitud_mantenimiento_id`);

--
-- Indices de la tabla `solicitud_mantenimientos`
--
ALTER TABLE `solicitud_mantenimientos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `solicitud_mantenimientos_codigo_unique` (`codigo`),
  ADD KEY `solicitud_mantenimientos_biometrico_id_foreign` (`biometrico_id`);

--
-- Indices de la tabla `unidad_areas`
--
ALTER TABLE `unidad_areas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unidad_areas_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `biometricos`
--
ALTER TABLE `biometricos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cronogramas`
--
ALTER TABLE `cronogramas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `documento_archivos`
--
ALTER TABLE `documento_archivos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT de la tabla `institucions`
--
ALTER TABLE `institucions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `solicitud_mantenimientos`
--
ALTER TABLE `solicitud_mantenimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `unidad_areas`
--
ALTER TABLE `unidad_areas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `biometricos`
--
ALTER TABLE `biometricos`
  ADD CONSTRAINT `biometricos_unidad_area_id_foreign` FOREIGN KEY (`unidad_area_id`) REFERENCES `unidad_areas` (`id`);

--
-- Filtros para la tabla `cronogramas`
--
ALTER TABLE `cronogramas`
  ADD CONSTRAINT `cronogramas_solicitud_mantenimiento_id_foreign` FOREIGN KEY (`solicitud_mantenimiento_id`) REFERENCES `solicitud_mantenimientos` (`id`),
  ADD CONSTRAINT `cronogramas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `documento_archivos`
--
ALTER TABLE `documento_archivos`
  ADD CONSTRAINT `documento_archivos_documento_id_foreign` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`id`);

--
-- Filtros para la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `servicios_solicitud_mantenimiento_id_foreign` FOREIGN KEY (`solicitud_mantenimiento_id`) REFERENCES `solicitud_mantenimientos` (`id`);

--
-- Filtros para la tabla `solicitud_mantenimientos`
--
ALTER TABLE `solicitud_mantenimientos`
  ADD CONSTRAINT `solicitud_mantenimientos_biometrico_id_foreign` FOREIGN KEY (`biometrico_id`) REFERENCES `biometricos` (`id`);

--
-- Filtros para la tabla `unidad_areas`
--
ALTER TABLE `unidad_areas`
  ADD CONSTRAINT `unidad_areas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
