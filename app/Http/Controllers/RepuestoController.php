<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Repuesto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class RepuestoController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1",
        "unidad_area_id" => "required",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "unidad_area_id.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Repuestos/Index");
    }

    public function listado()
    {
        $repuestos = Repuesto::where("status", 1)->get();
        return response()->JSON([
            "repuestos" => $repuestos
        ]);
    }

    public function byArea(Request $request)
    {
        $repuestos = Repuesto::where("unidad_area_id", $request->id)->where("repuestos.status", 1)->get();
        return response()->JSON([
            "repuestos" => $repuestos
        ]);
    }


    public function paginado(Request $request)
    {
        $search = $request->search;
        $repuestos = Repuesto::with(["unidad_area"])->select("repuestos.*")->where("repuestos.status", 1);

        if (trim($search) != "") {
            $repuestos->where("nombre", "LIKE", "%$search%");
        }

        $repuestos = $repuestos->orderBy("id", "desc")->paginate($request->itemsPerPage);
        return response()->JSON([
            "repuestos" => $repuestos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear el Repuesto
            $nuevo_repuesto = Repuesto::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_repuesto, "repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->repuesto . ' REGISTRO UN REPUESTO',
                'datos_original' => $datos_original,
                'modulo' => 'REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("repuestos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Repuesto $repuesto)
    {
    }

    public function update(Repuesto $repuesto, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($repuesto, "repuestos");
            $repuesto->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($repuesto, "repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->repuesto . ' MODIFICÓ UN REPUESTO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return redirect()->route("repuestos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Repuesto $repuesto)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($repuesto, "repuestos");
            $repuesto->status = 0;
            $repuesto->save();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->repuesto . ' ELIMINÓ UN REPUESTO',
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
