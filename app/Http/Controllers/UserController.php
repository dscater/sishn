<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{


    public static $permisos = [
        "ADMINISTRADOR" => [
            "usuarios.index",
            "usuarios.create",
            "usuarios.edit",
            "usuarios.destroy",

            "unidad_areas.index",
            "unidad_areas.create",
            "unidad_areas.edit",
            "unidad_areas.destroy",

            "empresas.index",
            "empresas.create",
            "empresas.edit",
            "empresas.destroy",

            "biometricos.index",
            "biometricos.create",
            "biometricos.edit",
            "biometricos.destroy",

            "repuestos.index",
            "repuestos.create",
            "repuestos.edit",
            "repuestos.destroy",

            "solicitud_mantenimientos.index",
            "solicitud_mantenimientos.create",
            "solicitud_mantenimientos.edit",
            "solicitud_mantenimientos.destroy",

            "servicios.index",
            "servicios.create",
            "servicios.edit",
            "servicios.destroy",

            "institucions.index",
            "institucions.create",
            "institucions.edit",
            "institucions.destroy",

            "reportes.usuarios",
            "reportes.solicitud_mantenimiento"
        ],
        "JEFE DE ÁREA" => [
            "solicitud_mantenimientos.index",
            "solicitud_mantenimientos.create",
            "solicitud_mantenimientos.edit",
            "solicitud_mantenimientos.destroy",
        ],
        "TÉCNICO" => [
            "solicitud_mantenimientos.index",
            "solicitud_mantenimientos.create",
            "solicitud_mantenimientos.edit",
            "solicitud_mantenimientos.destroy",
        ],
    ];


    public static function getPermisosUser()
    {
        $array_permisos = self::$permisos;
        if ($array_permisos[Auth::user()->tipo]) {
            return $array_permisos[Auth::user()->tipo];
        }
        return [];
    }


    public static function verificaPermiso($permiso)
    {
        if (in_array($permiso, self::$permisos[Auth::user()->tipo])) {
            return true;
        }
        return false;
    }

    public function permisos(Request $request)
    {
        return response()->JSON([
            "permisos" => $this->permisos[Auth::user()->tipo]
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()
        ]);
    }
}
