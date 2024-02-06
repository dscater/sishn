<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\SolicitudMantenimiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class SolicitudMantenimientoController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
    ];

    public function index()
    {
        return Inertia::render("SolicitudMantenimientos/Index");
    }

    public function listado()
    {
        $solicitud_mantenimientos = SolicitudMantenimiento::all();
        return response()->JSON([
            "solicitud_mantenimientos" => $solicitud_mantenimientos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $solicitud_mantenimientos = SolicitudMantenimiento::select("solicitud_mantenimientos.*");

        if (trim($search) != "") {
            $solicitud_mantenimientos->where("nombre", "LIKE", "%$search%");
        }

        $solicitud_mantenimientos = $solicitud_mantenimientos->paginate(5);
        return response()->JSON([
            "solicitud_mantenimientos" => $solicitud_mantenimientos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear el SolicitudMantenimiento
            $nuevo_solicitud_mantenimiento = SolicitudMantenimiento::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_solicitud_mantenimiento, "solicitud_mantenimientos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->solicitud_mantenimiento . ' REGISTRO UN REPUESTO',
                'datos_original' => $datos_original,
                'modulo' => 'REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("solicitud_mantenimientos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(SolicitudMantenimiento $solicitud_mantenimiento)
    {
    }

    public function update(SolicitudMantenimiento $solicitud_mantenimiento, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($solicitud_mantenimiento, "solicitud_mantenimientos");
            $solicitud_mantenimiento->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($solicitud_mantenimiento, "solicitud_mantenimientos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->solicitud_mantenimiento . ' MODIFICÓ UN REPUESTO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return redirect()->route("solicitud_mantenimientos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(SolicitudMantenimiento $solicitud_mantenimiento)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($solicitud_mantenimiento, "solicitud_mantenimientos");
            $solicitud_mantenimiento->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->solicitud_mantenimiento . ' ELIMINÓ UN REPUESTO',
                'datos_original' => $datos_original,
                'modulo' => 'REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
