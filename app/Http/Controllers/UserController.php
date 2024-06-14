<?php

namespace App\Http\Controllers;

use App\Models\Biometrico;
use App\Models\Empresa;
use App\Models\Servicio;
use App\Models\SolicitudMantenimiento;
use App\Models\UnidadArea;
use App\Models\User;
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

            "documentos.index",
            "documentos.create",
            "documentos.edit",
            "documentos.destroy",

            "institucions.index",
            "institucions.create",
            "institucions.edit",
            "institucions.destroy",

            "reportes.usuarios",
            "reportes.solicitud_mantenimiento",
            "reportes.servicio",
            "reportes.equipos",
            "reportes.repuestos",
            "reportes.historial_mantenimientos",
            "reportes.cantidad_mantenimiento_equipos",
            "reportes.cantidad_mantenimiento_mes",
        ],
        "JEFE DE ÁREA" => [
            "solicitud_mantenimientos.index",
            "solicitud_mantenimientos.create",
            "solicitud_mantenimientos.edit",
            "solicitud_mantenimientos.destroy",

            "servicios.index",
            "servicios.create",
            "servicios.edit",
            "servicios.destroy",

            "reportes.solicitud_mantenimiento",
            "reportes.servicio",
            "reportes.equipos",
            "reportes.repuestos",
            "reportes.historial_mantenimientos",
            "reportes.cantidad_mantenimiento_equipos",
            "reportes.cantidad_mantenimiento_mes",
        ],
        "TÉCNICO" => [
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

            "documentos.index",
            "documentos.create",
            "documentos.edit",
            "documentos.destroy",

            "reportes.solicitud_mantenimiento",
            "reportes.servicio",
            "reportes.equipos",
            "reportes.repuestos",
            "reportes.historial_mantenimientos",
            "reportes.cantidad_mantenimiento_equipos",
            "reportes.cantidad_mantenimiento_mes",
        ],
        "DIRECTOR" => [
            "documentos.index",
            "documentos.create",
            "documentos.edit",
            "documentos.destroy",

            "reportes.solicitud_mantenimiento",
            "reportes.servicio",
            "reportes.equipos",
            "reportes.repuestos",
            "reportes.historial_mantenimientos",
            "reportes.cantidad_mantenimiento_equipos",
            "reportes.cantidad_mantenimiento_mes",
        ]
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

    public static function getInfoBoxUser()
    {
        $tipo = Auth::user()->tipo;
        $array_infos = [];
        if (in_array('usuarios.index', self::$permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Usuarios',
                'cantidad' => count(User::where('id', '!=', 1)->get()),
                'color' => 'bg-blue-darken-4',
                'icon' => asset("imgs/icon_users.png"),
                "url" => "usuarios.index"
            ];
        }

        if (in_array('solicitud_mantenimientos.index', self::$permisos[$tipo])) {
            $solicitud_mantenimientos = SolicitudMantenimiento::select("solicitud_mantenimientos.*");
            if (Auth::user()->tipo == 'JEFE DE ÁREA') {
                $unidad_area = Auth::user()->unidad_area;
                $solicitud_mantenimientos->join("biometricos", "biometricos.id", "=", "solicitud_mantenimientos.biometrico_id");
                if ($unidad_area) {
                    $solicitud_mantenimientos->where("biometricos.unidad_area_id", $unidad_area->id);
                } else {
                    $solicitud_mantenimientos->where("biometricos.unidad_area_id", 0);
                }
            }
            $solicitud_mantenimientos = $solicitud_mantenimientos->get();
            $array_infos[] = [
                'label' => 'Solicitud de Mantenimientos',
                'cantidad' => count($solicitud_mantenimientos),
                'color' => 'bg-blue-darken-4',
                'icon' => asset("imgs/documents.png"),
                "url" => "usuarios.index"
            ];
        }

        if (in_array('servicios.index', self::$permisos[$tipo])) {
            $servicios = Servicio::select("servicios.*");
            $servicios->join("solicitud_mantenimientos", "solicitud_mantenimientos.id", "=", "servicios.solicitud_mantenimiento_id");
            if (Auth::user()->tipo == 'JEFE DE ÁREA') {
                $unidad_area = Auth::user()->unidad_area;
                $servicios->join("biometricos", "biometricos.id", "=", "solicitud_mantenimientos.biometrico_id");
                if ($unidad_area) {
                    $servicios->where("biometricos.unidad_area_id", $unidad_area->id);
                } else {
                    $servicios->where("biometricos.unidad_area_id", 0);
                }
            }
            $servicios = $servicios->get();
            $array_infos[] = [
                'label' => 'Servicios',
                'cantidad' => count($servicios),
                'color' => 'bg-blue-darken-4',
                'icon' => asset("imgs/checklist.png"),
                "url" => "usuarios.index"
            ];
        }

        if (in_array('biometricos.index', self::$permisos[$tipo])) {
            $biometricos = Biometrico::all();
            $array_infos[] = [
                'label' => 'Equipos Biomédicos',
                'cantidad' => count($biometricos),
                'color' => 'bg-blue-darken-4',
                'icon' => asset("imgs/boxes.png"),
                "url" => "usuarios.index"
            ];
        }

        if (in_array('empresas.index', self::$permisos[$tipo])) {
            $empresas = Empresa::all();
            $array_infos[] = [
                'label' => 'Empresas',
                'cantidad' => count($empresas),
                'color' => 'bg-blue-darken-4',
                'icon' => asset("imgs/enterprise.png"),
                "url" => "usuarios.index"
            ];
        }

        if (in_array('unidad_areas.index', self::$permisos[$tipo])) {
            $unidad_areas = UnidadArea::all();
            $array_infos[] = [
                'label' => 'Unidad/Áreas',
                'cantidad' => count($unidad_areas),
                'color' => 'bg-blue-darken-4',
                'icon' => asset("imgs/icon_solicitud.png"),
                "url" => "usuarios.index"
            ];
        }

        return $array_infos;
    }
}
