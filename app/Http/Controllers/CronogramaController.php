<?php

namespace App\Http\Controllers;

use App\Models\Cronograma;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CronogramaController extends Controller
{
    public function listado()
    {
        $cronogramas = Cronograma::with(["solicitud_mantenimiento.biometrico.unidad_area", "solicitud_mantenimiento.biometrico.empresa", "solicitud_mantenimiento.responsable", "solicitud_mantenimiento.tecnico"])->select("cronogramas.*");

        if (Auth::user()->tipo == 'JEFE DE ÁREA') {
            $unidad_area = Auth::user()->unidad_area;
            $cronogramas->join("solicitud_mantenimientos", "solicitud_mantenimientos.id", "=", "cronogramas.solicitud_mantenimiento_id");
            $cronogramas->join("biometricos", "biometricos.id", "=", "solicitud_mantenimientos.biometrico_id");
            $cronogramas->where("biometricos.unidad_area_id", $unidad_area->id);
        }

        $cronogramas = $cronogramas->get();

        return response()->JSON([
            "cronogramas" => $cronogramas,
        ]);
    }
}
