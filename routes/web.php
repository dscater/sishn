<?php

use App\Http\Controllers\BiometricoController;
use App\Http\Controllers\CronogramaController;
use App\Http\Controllers\DocumentoArchivoController;
use App\Http\Controllers\DocumentoController;
use App\Http\Controllers\EmpresaController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\InstitucionController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RepuestoController;
use App\Http\Controllers\ServicioController;
use App\Http\Controllers\SolicitudMantenimientoController;
use App\Http\Controllers\UnidadAreaController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::get('/', function () {
//     return Inertia::render('Welcome', [
//         'canLogin' => Route::has('login'),
//         'canRegister' => Route::has('register'),
//         'laravelVersion' => Application::VERSION,
//         'phpVersion' => PHP_VERSION,
//     ]);
// });

Route::get('/', function () {

    return Inertia::render('Inicio');
});

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
});

Route::get("institucions/getInstitucion", [InstitucionController::class, 'getInstitucion'])->name("institucions.getInstitucion");

Route::middleware('auth')->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');

    // INSTITUCION
    Route::get("Uo5qiu2RINWj8mz2Bw3p1w==", [InstitucionController::class, 'index'])->name("institucions.index");
    Route::get("dbnYjpPQUqsoUQmyyS+awaZLRLMP8LQrFbwUzSh+qVc={institucion}", [InstitucionController::class, 'show'])->name("institucions.show");
    Route::put("FVhFzve0l4uEkMlzrhuPc1dDs0qV5DuHocHeSSYummc={institucion}", [InstitucionController::class, 'update'])->name("institucions.update");

    // USUARIO
    Route::get('/6WX5siBxLM75k9aH0qrZHw==', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/6WX5siBxLM75k9aH0qrZHw==', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('/3wLOEP2FxOgR37pQSMDUQCuT9MAC8TbHFmb8YcMBQAc=', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('/6WX5siBxLM75k9aH0qrZHw', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get("/zBCxmLj1R2BhwADk14GriA==", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("/T7Ub9laScUJZs5r1XIjm4g==", [UserController::class, 'permisos']);
    Route::get("/ABjrOFSx9lwyQaGzeK5wxw==", [UserController::class, 'permisos']);

    // USUARIOS
    Route::put("/kzep7j5++dVtkVPOivgOH7vGtYDX4RYz0DAHR1WC1HU={user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("/B3glM/ZKVfkmYi9TuX0z9JIh192BikcrmRvPGWzghQg=", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("/5Ma0qujjlC/x3pk6VbmUweFWtQYAjjtlorU2kFEY42A=", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("/5Ma0qujjlC/x3pk6VbmUwXQditexD6cMOyHcOFHYw8c=", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("/SOVWj81Hk5mrMADbGmGNGA=={user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("/8QNXynYtN+sDweKBvkvERtcGQwlfgK5bugD717B5AzA={user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("/hwAyrs7mw6URuNM59dVwEg=={user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::get("/3bpI5oqqany9hvcp55X77w==", [UsuarioController::class, 'index'])->name("usuarios.index");
    Route::post("/2DuJlKBUFi2aaxoZ1XqycQ==", [UsuarioController::class, 'store'])->name("usuarios.store");

    // UNIDAD/AREAS
    Route::get("/vHzEGG4UCxh6kSfPhFsvM5BYp6lmJnJCS55dpNLFjec=", [UnidadAreaController::class, 'paginado'])->name("unidad_areas.paginado");
    Route::get("/J8Dtn01RA7csmZ7b4Nni94FjK0VC6IZtBL15te5i7I8=", [UnidadAreaController::class, 'listado'])->name("unidad_areas.listado");
    Route::get("/00aSY0tw7rs7EhKLt/fKRQ==", [UnidadAreaController::class, 'index'])->name("unidad_areas.index");
    Route::post("/4sRykgNd8MOvoAM3kYEtdVADY/k9zrirlYVp7BSbc3c=", [UnidadAreaController::class, 'store'])->name("unidad_areas.store");
    Route::get("/6SVO5BoYxNUM/X5zg+HzRnGoo3PGVlxGiCHi5k1DNw8={unidad_area}", [UnidadAreaController::class, 'show'])->name("unidad_areas.show");
    Route::put("/eyP2qfhGlTA2gcVgbf/Rm9yADVkE5qXnkbYuyFqSI64={unidad_area}", [UnidadAreaController::class, 'update'])->name("unidad_areas.update");
    Route::delete("/p/6jORulIYVpTmWffFqKSIHM9mK3qAkvjSk5Ow5EdMc={unidad_area}", [UnidadAreaController::class, 'destroy'])->name("unidad_areas.destroy");

    // EMPRESAS
    Route::get("/NF81vWyYmciP4FZEfcjJJ3ESeQ3PmPcZq6uBfyVF3Lw=", [EmpresaController::class, 'paginado'])->name("empresas.paginado");
    Route::get("/MAO40nf3xMq7C8zKlYMIT2pBgpdG1yZpd48vywGBfS4=", [EmpresaController::class, 'listado'])->name("empresas.listado");
    Route::get("/ZDjIfieUOCt8klK7Mx8wOQ==", [EmpresaController::class, 'index'])->name("empresas.index");
    Route::post("/EK18wFV5gsFVqaFukgfgwQ==", [EmpresaController::class, 'store'])->name("empresas.store");
    Route::get("/jo/FWzu2eWldosQkep+vgQ=={empresa}", [EmpresaController::class, 'show'])->name("empresas.show");
    Route::put("/ANmSdeORMHG7kYDbTJzWag=={empresa}", [EmpresaController::class, 'update'])->name("empresas.update");
    Route::delete("/Dj/S61U3GsXfcGUAr7ouWAsf//ybDtAubL15McP5tJA={empresa}", [EmpresaController::class, 'destroy'])->name("empresas.destroy");

    // BIOMETRICOS
    Route::get("/Qgg7OtuKaXVu548ss5ekORHs5E6tONz9HuQaJU7HcfE=", [BiometricoController::class, 'porArea'])->name("biometricos.porArea");
    Route::get("/dNKSzHAHuTZ0FwCachzyX1JAzYY8iKT8IYIeM3zzPcI=", [BiometricoController::class, 'paginado'])->name("biometricos.paginado");
    Route::get("/KpVq+QeMZ0vJYcVQn0OJKaOm88id+ff68ryFhFh9aLY=", [BiometricoController::class, 'listado'])->name("biometricos.listado");
    Route::get("/rI8DfJUDVN3uNUnNBBlCJg==", [BiometricoController::class, 'index'])->name("biometricos.index");
    Route::post("/DRjrGgSL9LmjovtCfhlTEkvnEfOLikQZruA8Ewpbvio=", [BiometricoController::class, 'store'])->name("biometricos.store");
    Route::get("/JMqjFIbMLSiU7Xi3SfW2upIuPWvFgxwL1tYy8C6/JvQ={biometrico}", [BiometricoController::class, 'show'])->name("biometricos.show");
    Route::put("/tZQgVjpsCAPTJbey2Q7WNqiKOXlbiS1cSm27SPGw+0I={biometrico}", [BiometricoController::class, 'update'])->name("biometricos.update");
    Route::delete("/2TvhGkmX11GmcEqcBK8ix6ui5+bul2B4VAFX7suM1fI={biometrico}", [BiometricoController::class, 'destroy'])->name("biometricos.destroy");

    // REPUESTOS
    Route::get("/EeuprOaoRu/ZB4q5vQdEUv2h3j3iad47wSoU3/9OCZI=", [RepuestoController::class, 'paginado'])->name("repuestos.paginado");
    Route::get("/GsixF9n5Qy+ciDBozHPm3FX4U7rczwirGoFRHEGBM7k=", [RepuestoController::class, 'listado'])->name("repuestos.listado");
    Route::get("/Co91OCBx39qiugGTNrBlTg==", [RepuestoController::class, 'index'])->name("repuestos.index");
    Route::post("/E/m7M6t65TxbKupOBR2Q8g==", [RepuestoController::class, 'store'])->name("repuestos.store");
    Route::get("/n/J7aHGDEJgYpoQfl3UJ6w=={repuesto}", [RepuestoController::class, 'show'])->name("repuestos.show");
    Route::put("/0Yr3Li8eIPhtS5Li23OYIE7Wy8FMUGHpwXJuAHJ0ERU={repuesto}", [RepuestoController::class, 'update'])->name("repuestos.update");
    Route::delete("/airNAk2B3Qc4DdwFcjPF76MlS/trAzOe1AQ6IBfPOxY={repuesto}", [RepuestoController::class, 'destroy'])->name("repuestos.destroy");

    // SOLICITUD DE MANTENIMIENTOS
    Route::get("/NMvZP0JLeAsziTpHdAFJXTzukTseeiXFvdNbi5hH9e8UMWXv7aqKavZleRbav0OJ", [SolicitudMantenimientoController::class, 'cronogramas'])->name("solicitud_mantenimientos.cronogramas");
    Route::get("/NMvZP0JLeAsziTpHdAFJXdy7KINw5BZSHx7aUxQ66ci9NKzPPqoNkhw0/r3zCqU3", [SolicitudMantenimientoController::class, 'getByUnidadAreaId'])->name("solicitud_mantenimientos.getByUnidadAreaId");
    Route::get("/NMvZP0JLeAsziTpHdAFJXZ1CY5ZZBykDQJmZtG/Z8mbuz2O3WLVRMxjiYW74rsxg{solicitud_mantenimiento}", [SolicitudMantenimientoController::class, 'getById'])->name("solicitud_mantenimientos.getById");
    Route::get("/NMvZP0JLeAsziTpHdAFJXVCckfyYqKjCNRowq4RbqYZQ+yYRV/e14ntqTaG2opti", [SolicitudMantenimientoController::class, 'paginado'])->name("solicitud_mantenimientos.paginado");
    Route::get("/NMvZP0JLeAsziTpHdAFJXQ20zlIUR/h5tp9h9LhfEKhmhjbef/M9O44DqBQnl9or", [SolicitudMantenimientoController::class, 'listado'])->name("solicitud_mantenimientos.listado");
    Route::get("/NMvZP0JLeAsziTpHdAFJXVLvyYR6/sR/oHiE6eipJOA=", [SolicitudMantenimientoController::class, 'index'])->name("solicitud_mantenimientos.index");
    Route::get("/NMvZP0JLeAsziTpHdAFJXbVj7nwOLNZ70wq/g5z+r6w=", [SolicitudMantenimientoController::class, 'create'])->name("solicitud_mantenimientos.create");
    Route::get("/NMvZP0JLeAsziTpHdAFJXXPQBysrzSVRG1ZdiKqJv8I={solicitud_mantenimiento}", [SolicitudMantenimientoController::class, 'edit'])->name("solicitud_mantenimientos.edit");
    Route::post("/NMvZP0JLeAsziTpHdAFJXfiZnNkJIcrOxYPBvwmkTGA=", [SolicitudMantenimientoController::class, 'store'])->name("solicitud_mantenimientos.store");
    Route::get("/NMvZP0JLeAsziTpHdAFJXcV3upYPpI0Zvw8UyMVSzSc={solicitud_mantenimiento}", [SolicitudMantenimientoController::class, 'show'])->name("solicitud_mantenimientos.show");
    Route::put("/NMvZP0JLeAsziTpHdAFJXV8+d0ce8QLjpGBD6Z7Oslk={solicitud_mantenimiento}", [SolicitudMantenimientoController::class, 'update'])->name("solicitud_mantenimientos.update");
    Route::delete("/NMvZP0JLeAsziTpHdAFJXSPHoR0/4o7AmRKgPWttlWSbpyGlZJ65nVJ52XDb/6C3{solicitud_mantenimiento}", [SolicitudMantenimientoController::class, 'destroy'])->name("solicitud_mantenimientos.destroy");

    // DOCUMENTOS
    Route::get("/zMBJBHTqVLZXT63p0I3bLUaFHv+wgCMnY0CijQlbEI0=", [DocumentoController::class, 'paginado'])->name("documentos.paginado");
    Route::get("/Is47w3md+6ERfhbBDsJxghrEbHyajFLBczGIuEPKbe8=", [DocumentoController::class, 'listado'])->name("documentos.listado");
    Route::get("/JgcliVpnWL0sK11hq0YjQg==", [DocumentoController::class, 'index'])->name("documentos.index");
    Route::get("/i3CqPnIuHeoYbvOFe6Dy1Cun1JALwvQBgguwW101cvM=", [DocumentoController::class, 'create'])->name("documentos.create");
    Route::post("/aqyyH+FAO5k6j+tIk4xQf2FspyW60itZAf2grcU7m1o=", [DocumentoController::class, 'store'])->name("documentos.store");
    Route::get("/1mjEOt7Km319tOnVWDRlzw=={documento}", [DocumentoController::class, 'edit'])->name("documentos.edit");
    Route::put("/GyX9a/FkLg3oQMnJG+x1YBFUyfoehaI4A4AO5Mg2F3c={documento}", [DocumentoController::class, 'update'])->name("documentos.update");
    Route::get("/P+iDWUhDe/qaLssdoo6Ljg=={documento}", [DocumentoController::class, 'show'])->name("documentos.show");
    Route::delete("/p1WCgsriKAnMQYSL88v+gmjnpfwVQmWCx+p+3Wduqpk={documento}", [DocumentoController::class, 'destroy'])->name("documentos.destroy");

    // DOCUMENTO ARCHIVOS
    Route::delete("/Ot2GA6H6ZCvtIWJpFyrp8J6UOm7bDjGuc3mbjtSBbo4={documento_archivo}", [DocumentoArchivoController::class, 'destroy'])->name("documento_archivos.destroy");

    // SERVICIOS
    Route::get("/sF1lS6wT6LyJ2JCz4lJVK6DyfVMWOeHgI7678E08CGM=", [ServicioController::class, 'paginado'])->name("servicios.paginado");
    Route::get("/7jVa+qhKXwyi/IT23+swdqeqR0v1mJISp9NbTRx5OQg=", [ServicioController::class, 'listado'])->name("servicios.listado");
    Route::get("/f+MTUbFwsYOvfcIWH9yiGg==", [ServicioController::class, 'index'])->name("servicios.index");
    Route::get("/GnuAuHQgogwhhiSUdSLZEhkTKfPsDrkWSDA+tVcoSTM=", [ServicioController::class, 'create'])->name("servicios.create");
    Route::get("/2ABr4HV483rBVTeHwiJmEQ=={servicio}", [ServicioController::class, 'edit'])->name("servicios.edit");
    Route::post("/LJIC9BKIprDSmZVXo9RSLA==", [ServicioController::class, 'store'])->name("servicios.store");
    Route::get("/5HfB73SHZveWFodLvBKrJw=={servicio}", [ServicioController::class, 'show'])->name("servicios.show");
    Route::put("/bvhcnc8nBpByi0fV/wmxsokyfXfxkpU/PkjWljI0Kck={servicio}", [ServicioController::class, 'update'])->name("servicios.update");
    Route::delete("/Wuk47+9W7+XkQNK9hHBxcCmAq5C+5v3Z+wb7vX6S3LU={servicio}", [ServicioController::class, 'destroy'])->name("servicios.destroy");

    // CRONOGRAMAS
    Route::get("/AmVl/xisao28tvDKaPbHKdu4IPPxtE/KaIaaCAcBGG4=", [CronogramaController::class, 'listado'])->name("cronogramas.listado");
    // Route::resource("cronogramas", CronogramaController::class)->only(
    //     ["index", "store", "show", "update", "destroy"]
    // );

    // REPORTES
    Route::get('bnVNI+ZavsLXqzuXRm8kgvCYHfH7duwJv8yDd5IqidA=', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('d/3aFQQOq6M4TatfvFSEJZh5xB3xQkcDzSisUF3vG0s=', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");

    Route::get('6t+QRKzs6OpMrkIZRUqBXqLkGpt0xNwg8nTcNsgsJhC003EgEPvJJDfNtYEGXAv6', [ReporteController::class, 'solicitud_mantenimiento'])->name("reportes.solicitud_mantenimiento");
    Route::get('olGe786src7pImcq6BF5Q1SEnbHdsNqr77hiFT1v9ZYznudVnTr090FeB0jKhgiC', [ReporteController::class, 'r_solicitud_mantenimiento'])->name("reportes.r_solicitud_mantenimiento");

    Route::get('uM0mQXHhPeSiFlZhp68IRZwoZJo5ziDbUni6KaD4GkU=', [ReporteController::class, 'servicio'])->name("reportes.servicio");
    Route::get('Kv6T9VlO2Gnk2KAFbrSfObosnR+jkVGfZsdePHEk2I4=', [ReporteController::class, 'r_servicio'])->name("reportes.r_servicio");

    Route::get('y3/8AqiBvS3FVj33hRrK5kJ+PMCvD+bjZchtyTP4nF4=', [ReporteController::class, 'equipos'])->name("reportes.equipos");
    Route::get('/DorIWV2B0lh8zx93k+Vgp89fc+31dXYK4BNRtC6rTs=', [ReporteController::class, 'r_equipos'])->name("reportes.r_equipos");

    Route::get('NCmk9YTsQNGCscr4D0JsZcgXZQI5s6piP71O2KRmdAQvTXGf5MmAMazE2pcJj8sM', [ReporteController::class, 'historial_mantenimientos'])->name("reportes.historial_mantenimientos");
    Route::get('HG4lGf+lN85lKoEnHpIDtDdguT9R7opTbXybg3nDYz9pIk4mnnN9GHSWEyXfEWwM', [ReporteController::class, 'r_historial_mantenimientos'])->name("reportes.r_historial_mantenimientos");

    Route::get('hoXtbx/fQNXPXTa+QvGh54ew/Hmj0El7ts2i7prDjLJejBRGfiBXcYfs638UA8Gd', [ReporteController::class, 'cantidad_mantenimiento_equipos'])->name("reportes.cantidad_mantenimiento_equipos");
    Route::get('CS1Mc5Sfj/I2HUZkH0kVGoFbJl0PMX6j8lFhmYWwjhchAkHlxgtlIwHxk5bBu6T9', [ReporteController::class, 'r_cantidad_mantenimiento_equipos'])->name("reportes.r_cantidad_mantenimiento_equipos");

    Route::get('hoXtbx/fQNXPXTa+QvGh54ew/Hmj0El7ts2i7prDjLIMI2OMiPtq45xnW5Nty5K5', [ReporteController::class, 'cantidad_mantenimiento_mes'])->name("reportes.cantidad_mantenimiento_mes");
    Route::get('CS1Mc5Sfj/I2HUZkH0kVGoFbJl0PMX6j8lFhmYWwjhd5zK6q/CoBhbsS3n0/JUXo', [ReporteController::class, 'r_cantidad_mantenimiento_mes'])->name("reportes.r_cantidad_mantenimiento_mes");
});

require __DIR__ . '/auth.php';
