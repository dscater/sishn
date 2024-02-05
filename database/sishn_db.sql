-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 05-02-2024 a las 22:25:39
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
  `unidad_area_id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`, `nit`, `fono`, `fecha_ini`, `fecha_fin`, `correo`, `dir`, `logo`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'EMPRESA #1', '111111', '7777777', '2024-01-01', '2024-09-03', 'EMPRESA1@GMAIL.COM', 'LOS OLIVOS', '1707171817_1.jpg', '2024-02-05', '2024-02-05 22:23:37', '2024-02-05 22:23:37'),
(2, 'EMPRESA #2', '', '', NULL, NULL, '', '', NULL, '2024-02-05', '2024-02-05 22:23:45', '2024-02-05 22:23:45'),
(3, 'EMPRESA 3', '33', '33', '2024-03-03', '2024-02-06', '', '', NULL, '2024-02-05', '2024-02-05 22:24:32', '2024-02-05 22:24:32');

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
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA EMPRESA', 'id: 2<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:45<br/>updated_at: 2024-02-05 18:23:45<br/>', 'id: 2<br/>nombre: EMPRESA #2<br/>nit: <br/>fono: <br/>fecha_ini: <br/>fecha_fin: <br/>correo: <br/>dir: <br/>logo: <br/>fecha_registro: 2024-02-05<br/>created_at: 2024-02-05 18:23:45<br/>updated_at: 2024-02-05 18:23:45<br/>', 'EMPRESAS', '2024-02-05', '18:25:01', '2024-02-05 22:25:01', '2024-02-05 22:25:01');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `institucions`
--

INSERT INTO `institucions` (`id`, `nombre`, `nombre_sistema`, `nit`, `historia`, `mision`, `vision`, `objetivo`, `nombre_director`, `foto_director`, `nombre_subdirector`, `foto_subdirector`, `fono1`, `fono2`, `correo1`, `correo2`, `facebook`, `youtube`, `twitter`, `dir`, `ubicacion_google`, `img_organigrama`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'INSTITUCIÓN S.A', 'NOMBRE SISTEMA', '111111111', 'LOREM IPSUM ES SIMPLEMENTE EL TEXTO DE RELLENO DE LAS IMPRENTAS Y ARCHIVOS DE TEXTO. LOREM IPSUM HA SIDO EL TEXTO DE RELLENO ESTÁNDAR DE LAS INDUSTRIAS DESDE EL AÑO 1500, CUANDO UN IMPRESOR (N. DEL T. PERSONA QUE SE DEDICA A LA IMPRENTA) DESCONOCIDO USÓ UNA GALERÍA DE TEXTOS Y LOS MEZCLÓ DE TAL MANERA QUE LOGRÓ HACER UN LIBRO DE TEXTOS ESPECIMEN. NO SÓLO SOBREVIVIÓ 500 AÑOS, SINO QUE TAMBIEN INGRESÓ COMO TEXTO DE RELLENO EN DOCUMENTOS ELECTRÓNICOS,', 'LOREM IPSUM ES SIMPLEMENTE EL TEXTO DE RELLENO DE LAS IMPRENTAS Y ARCHIVOS DE TEXTO. LOREM IPSUM HA SIDO EL TEXTO DE RELLENO ESTÁNDAR DE LAS INDUSTRIAS DESDE EL AÑO 1500, CUANDO UN IMPRESOR (N. DEL T. PERSONA QUE SE DEDICA A LA IMPRENTA) DESCONOCIDO USÓ UNA GALERÍA DE TEXTOS Y LOS MEZCLÓ DE TAL MANERA QUE LOGRÓ HACER UN LIBRO DE TEXTOS ESPECIMEN. NO SÓLO SOBREVIVIÓ 500 AÑOS, SINO QUE TAMBIEN INGRESÓ COMO TEXTO DE RELLENO EN DOCUMENTOS ELECTRÓNICOS', '', 'LOREM IPSUM ES SIMPLEMENTE EL TEXTO DE RELLENO DE LAS IMPRENTAS Y ARCHIVOS DE TEXTO. LOREM IPSUM HA SIDO EL TEXTO DE RELLENO ESTÁNDAR DE LAS INDUSTRIAS DESDE EL AÑO 1500, CUANDO UN IMPRESOR (N. DEL T. PERSONA QUE SE DEDICA A LA IMPRENTA) DESCONOCIDO USÓ UNA GALERÍA DE TEXTOS Y LOS MEZCLÓ DE TAL MANERA QUE LOGRÓ HACER UN LIBRO DE TEXTOS ESPECIMEN. NO SÓLO SOBREVIVIÓ 500 AÑOS, SINO QUE TAMBIEN INGRESÓ COMO TEXTO DE RELLENO EN DOCUMENTOS ELECTRÓNICOS', 'JUAN PERESSS', '1706834799_1.png', 'JOSE PAREDES', '1706834920_1.jpg', '777777', '666666', 'CORREO1@GMAIL.COM', 'CORREO2@GMAIL.COM', 'FACEBOOK', 'YOUTUBE', 'TWITTER', 'LOS OLIVOS', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d12143.389812786238!2d-68.08918332465664!3d-16.52975316867156!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.527973505058714!2d-68.08870645756463!5e0!3m2!1ses-419!2sbo!4v1706929714970!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', '1706930367_1.WEBP', '1706995069_1.jpg', NULL, '2024-02-03 21:17:49');

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
(14, '2024_02_02_211435_create_servicios_table', 2);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_mantenimientos`
--

CREATE TABLE `solicitud_mantenimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_responsable` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_responsable` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_tecnico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci_tecnico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_mantenimiento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `motivo_mantenimiento` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `diagnostico` text COLLATE utf8mb4_unicode_ci,
  `otros` text COLLATE utf8mb4_unicode_ci,
  `fecha_solicitud` date NOT NULL,
  `biometrico_id` bigint UNSIGNED NOT NULL,
  `repuestos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidad_areas`
--

INSERT INTO `unidad_areas` (`id`, `nombre`, `descripcion`, `user_id`, `ubicacion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'UNIDAD #1', 'DESC. #1', 2, 'UBICACION #1', '2024-02-05', '2024-02-05 21:35:08', '2024-02-05 21:35:08');

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
  `acceso` int NOT NULL DEFAULT '1',
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `email`, `fono`, `tipo`, `foto`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 'admin', NULL, NULL, '0', '', '', 'admin@gmail.com', '', 'ADMINISTRADOR', NULL, 1, '2024-01-31', NULL, '2024-02-02 18:13:58'),
(2, 'JPERES', '$2y$12$K9AOPb12uULsg1TRY3QPseyxasLnvrLYkisBXai3aU3gdfQowza5K', 'JUAN', 'PERES', 'MAMANI', '1234', 'LP', 'LOS OLIVOS', 'JUAN@GMAIL.COM', '777777', 'JEFE DE ÁREA', '1707167967_JPERES.jpg', 1, '2024-02-05', '2024-02-05 21:19:27', '2024-02-05 21:19:27');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `institucions`
--
ALTER TABLE `institucions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitud_mantenimientos`
--
ALTER TABLE `solicitud_mantenimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unidad_areas`
--
ALTER TABLE `unidad_areas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `biometricos`
--
ALTER TABLE `biometricos`
  ADD CONSTRAINT `biometricos_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `biometricos_unidad_area_id_foreign` FOREIGN KEY (`unidad_area_id`) REFERENCES `unidad_areas` (`id`);

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
