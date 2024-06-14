<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\UnidadArea;
use Illuminate\Validation\ValidationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class UnidadAreaController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1",
        "user_id" => "required",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "user_id.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("UnidadAreas/Index");
    }

    public function listado()
    {
        $unidad_areas = UnidadArea::all();

        if (Auth::user()->tipo == 'JEFE DE ÁREA') {
            $unidad_area = Auth::user()->unidad_area;
            if ($unidad_area) {
                $unidad_areas =  UnidadArea::where("id", $unidad_area->id)->where("status", 1)->get();
            } else {
                $unidad_areas = [];
            }
        }
        return response()->JSON([
            "unidad_areas" => $unidad_areas
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $unidad_areas = UnidadArea::with(["user"]);

        if (trim($search) != "") {
            $unidad_areas->where("nombre", "LIKE", "%$search%");
        }

        $unidad_areas = $unidad_areas->where("status", 1)->orderBy("id", "desc")->paginate($request->itemsPerPage);
        return response()->JSON([
            "unidad_areas" => $unidad_areas
        ]);
    }

    public function store(Request $request)
    {
        // validar existena
        $existe_responsable = UnidadArea::where("user_id", $request->user_id)->get()->first();
        if ($existe_responsable) {
            Inertia::share('errors', ['user_id' => 'El usuario que seleccionó ya se encuentra asignado en otra Unidad/Área']);
            throw ValidationException::withMessages([
                "error" => ["El usuario que seleccionó ya se encuentra asignado en otra Unidad/Área"],
                "user_id" => ["Usuario no disponible"]
            ]);
            return Inertia::render("UnidadAreas/Index");
        }
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear la UnidadArea
            $nueva_unidad_area = UnidadArea::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_unidad_area, "unidad_areas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->unidad_area . ' REGISTRO UNA UNIDAD/ÁREA',
                'datos_original' => $datos_original,
                'modulo' => 'UNIDADES Y ÁREAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("unidad_areas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(UnidadArea $unidad_area)
    {
    }

    public function update(UnidadArea $unidad_area, Request $request)
    {      // validar existena
        $existe_responsable = UnidadArea::where("user_id", $request->user_id)->where("id", "!=", $unidad_area->id)->get()->first();
        if ($existe_responsable) {
            Inertia::share('errors', ['user_id' => 'El usuario que seleccionó ya se encuentra asignado en otra Unidad/Área']);
            throw ValidationException::withMessages([
                "error" => ["El usuario que seleccionó ya se encuentra asignado en otra Unidad/Área"],
                "user_id" => ["Usuario no disponible"]
            ]);
            return Inertia::render("UnidadAreas/Index");
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($unidad_area, "unidad_areas");
            $unidad_area->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($unidad_area, "unidad_areas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->unidad_area . ' MODIFICÓ UNA UNIDAD/ÁREA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'UNIDADES Y ÁREAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return redirect()->route("unidad_areas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(UnidadArea $unidad_area)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($unidad_area, "unidad_areas");
            $unidad_area->status = 0;
            $unidad_area->save();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->unidad_area . ' ELIMINÓ UNA UNIDAD/ÁREA',
                'datos_original' => $datos_original,
                'modulo' => 'UNIDADES Y ÁREAS',
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
