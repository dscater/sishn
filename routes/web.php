<?php

use App\Http\Controllers\BiometricoController;
use App\Http\Controllers\EmpresaController;
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
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
});

Route::get("institucions/getInstitucion", [InstitucionController::class, 'getInstitucion'])->name("institucions.getInstitucion");

Route::middleware('auth')->group(function () {
    // INICIO
    Route::get('/inicio', function () {
        return Inertia::render('Home');
    })->name('inicio');

    // INSTITUCION
    Route::resource("institucions", InstitucionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('/profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get("/getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("/permisos", [UserController::class, 'permisos']);
    Route::get("/menu_user", [UserController::class, 'permisos']);

    // USUARIOS
    Route::get("/usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("/usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("/usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("/usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("/usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("/usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // UNIDAD/AREAS
    Route::get("/unidad_areas/paginado", [UnidadAreaController::class, 'paginado'])->name("unidad_areas.paginado");
    Route::get("/unidad_areas/listado", [UnidadAreaController::class, 'listado'])->name("unidad_areas.listado");
    Route::resource("unidad_areas", UnidadAreaController::class)->only(
        ["index", "store", "show", "update", "destroy"]
    );

    // EMPRESAS
    Route::get("/empresas/paginado", [EmpresaController::class, 'paginado'])->name("empresas.paginado");
    Route::get("/empresas/listado", [EmpresaController::class, 'listado'])->name("empresas.listado");
    Route::resource("empresas", EmpresaController::class)->only(
        ["index", "store", "show", "update", "destroy"]
    );

    // BIOMETRICOS
    Route::get("/biometricos/paginado", [BiometricoController::class, 'paginado'])->name("biometricos.paginado");
    Route::get("/biometricos/listado", [BiometricoController::class, 'listado'])->name("biometricos.listado");
    Route::resource("biometricos", BiometricoController::class)->only(
        ["index", "store", "show", "update", "destroy"]
    );

    // REPUESTOS
    Route::get("/repuestos/paginado", [RepuestoController::class, 'paginado'])->name("repuestos.paginado");
    Route::get("/repuestos/listado", [RepuestoController::class, 'listado'])->name("repuestos.listado");
    Route::resource("repuestos", RepuestoController::class)->only(
        ["index", "store", "show", "update", "destroy"]
    );

    // SOLICITUD DE MANTENIMIENTOS
    Route::get("/solicitud_mantenimientos/getByUnidadAreaId", [SolicitudMantenimientoController::class, 'getByUnidadAreaId'])->name("solicitud_mantenimientos.getByUnidadAreaId");
    Route::get("/solicitud_mantenimientos/getById/{solicitud_mantenimiento}", [SolicitudMantenimientoController::class, 'getById'])->name("solicitud_mantenimientos.getById");
    Route::get("/solicitud_mantenimientos/paginado", [SolicitudMantenimientoController::class, 'paginado'])->name("solicitud_mantenimientos.paginado");
    Route::get("/solicitud_mantenimientos/listado", [SolicitudMantenimientoController::class, 'listado'])->name("solicitud_mantenimientos.listado");
    Route::resource("solicitud_mantenimientos", SolicitudMantenimientoController::class)->only(
        ["index", "create", "edit", "store", "show", "update", "destroy"]
    );

    // SERVICIOS
    Route::get("/servicios/paginado", [ServicioController::class, 'paginado'])->name("servicios.paginado");
    Route::get("/servicios/listado", [ServicioController::class, 'listado'])->name("servicios.listado");
    Route::resource("servicios", ServicioController::class)->only(
        ["index", "create", "edit", "store", "show", "update", "destroy"]
    );


    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");
    
    Route::get('reportes/solicitud_mantenimiento', [ReporteController::class, 'solicitud_mantenimiento'])->name("reportes.solicitud_mantenimiento");
    Route::get('reportes/r_solicitud_mantenimiento', [ReporteController::class, 'r_solicitud_mantenimiento'])->name("reportes.r_solicitud_mantenimiento");
});

require __DIR__ . '/auth.php';
