<?php

use App\Http\Controllers\EmpresaController;
use App\Http\Controllers\InstitucionController;
use App\Http\Controllers\ProfileController;
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
    // BORRAR
    Route::get('/vuetify', function () {
        return Inertia::render('Vuetify/Index');
    })->name("vuetify");

    // INICIO
    Route::get('/inicio', function () {
        return Inertia::render('Home');
    })->name('inicio');

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

    // INSTITUCION
    Route::resource("institucions", InstitucionController::class)->only(
        ["index", "show", "update"]
    );
});

require __DIR__ . '/auth.php';
