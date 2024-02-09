<?php

namespace App\Http\Controllers;

use App\Models\Cronograma;
use App\Models\HistorialAccion;
use App\Models\SolicitudMantenimiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class SolicitudMantenimientoController extends Controller
{
    public $validacion = [];

    public $mensajes = [
        "biometrico_id.required" => "Este campo es obligatorio",
        "nombre_responsable.required" => "Este campo es obligatorio",
        "nombre_responsable.min" => "Debes ingresar al menos :min caracteres",
        "motivo_mantenimiento.required" => "Este campo es obligatorio",
        "motivo_mantenimiento.min" => "Debes ingresar al menos :min caracteres",
        "array_repuestos.required" => "Debes seleccionar al menos un repuesto",
        "cronogramas" => "Debes ingresar algo en el cronograma",
    ];

    public function index()
    {
        return Inertia::render("SolicitudMantenimientos/Index");
    }

    public function listado(Request $request)
    {
        $solicitud_mantenimientos = SolicitudMantenimiento::select("solicitud_mantenimientos.*");

        if (Auth::user()->tipo == 'JEFE DE ÁREA') {
            $unidad_area = Auth::user()->unidad_area;
            $solicitud_mantenimientos->join("biometricos", "biometricos.id", "=", "solicitud_mantenimientos.biometrico_id");
            $solicitud_mantenimientos->where("biometricos.unidad_area_id", $unidad_area->id);
        }

        if ($request->order && $request->order == "desc") {
            $solicitud_mantenimientos->orderBy("solicitud_mantenimientos.id", "desc");
        }

        $solicitud_mantenimientos = $solicitud_mantenimientos->get();

        return response()->JSON([
            "solicitud_mantenimientos" => $solicitud_mantenimientos
        ]);
    }

    public function getByUnidadAreaId(Request $request)
    {
        $solicitud_mantenimientos = SolicitudMantenimiento::select("solicitud_mantenimientos.*");

        if (Auth::user()->tipo == 'JEFE DE ÁREA') {
            $unidad_area = Auth::user()->unidad_area;
            $solicitud_mantenimientos->join("biometricos", "biometricos.id", "=", "solicitud_mantenimientos.biometrico_id");
            $solicitud_mantenimientos->where("biometricos.unidad_area_id", $unidad_area->id);
        } else {
            $solicitud_mantenimientos->join("biometricos", "biometricos.id", "=", "solicitud_mantenimientos.biometrico_id");
            $solicitud_mantenimientos->where("biometricos.unidad_area_id", $request->unidad_area_id);
        }

        if ($request->order && $request->order == "desc") {
            $solicitud_mantenimientos->orderBy("solicitud_mantenimientos.id", "desc");
        }

        $solicitud_mantenimientos = $solicitud_mantenimientos->get();

        return response()->JSON([
            "solicitud_mantenimientos" => $solicitud_mantenimientos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $solicitud_mantenimientos = SolicitudMantenimiento::select("solicitud_mantenimientos.*")
            ->with("biometrico");

        if (trim($search) != "") {
            $solicitud_mantenimientos->where("codigo", "LIKE", "%$search%");
        }

        if (Auth::user()->tipo == 'JEFE DE ÁREA') {
            $unidad_area = Auth::user()->unidad_area;
            $solicitud_mantenimientos->join("biometricos", "biometricos.id", "=", "solicitud_mantenimientos.biometrico_id");
            $solicitud_mantenimientos->where("biometricos.unidad_area_id", $unidad_area->id);
        }

        $solicitud_mantenimientos = $solicitud_mantenimientos->paginate($request->itemsPerPage);
        return response()->JSON([
            "solicitud_mantenimientos" => $solicitud_mantenimientos
        ]);
    }

    public function create()
    {
        return Inertia::render('SolicitudMantenimientos/Create');
    }

    public function store(Request $request)
    {
        if (Auth::user()->tipo == 'JEFE DE ÁREA' || Auth::user()->tipo == 'ADMINISTRADOR') {
            $this->validacion["biometrico_id"] = "required";
            $this->validacion["nombre_responsable"] = "required|min:1";
            $this->validacion["motivo_mantenimiento"] = "required|min:1";
            $this->validacion["fecha_solicitud"] = "required|date";
            $this->validacion["array_repuestos"] = "required|min:1";
            $this->validacion["cronogramas"] = "required|min:1";
        }
        if (Auth::user()->tipo == 'TÉCNICO') {
            $this->validacion["biometrico_id"] = "required";
            $this->validacion["nombre_responsable"] = "required|min:1";
            $this->validacion["motivo_mantenimiento"] = "required|min:1";
            $this->validacion["fecha_solicitud"] = "required|date";
            $this->validacion["fecha_entrega"] = "required|date";
            $this->validacion["array_repuestos"] = "required|min:1";
            $this->validacion["cronogramas"] = "required|min:1";
        }

        if (!$request->fecha_entrega) {
            unset($request["fecha_entrega"]);
        }
        if (!$request->cronogramas || count($request->cronogramas) <= 0) {
            throw ValidationException::withMessages([
                "cronogramas" => "Debes completar el cronograma",
                "error" => "Debes completar el cronograma",
            ]);
        }

        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request["fecha_registro"] = date("Y-m-d");
            // crear el SolicitudMantenimiento
            $nro_codigo = SolicitudMantenimiento::getNroCodigo();
            $request["codigo"] = "SOL.MAT." . $nro_codigo;
            $request["nro"] = $nro_codigo;
            $repuestos = implode(",", $request->array_repuestos);
            $request["repuestos"] = $repuestos;
            $nueva_solicitud_mantenimiento = SolicitudMantenimiento::create(array_map('mb_strtoupper', $request->except("cronogramas", "array_repuestos", "eliminados")));
            $cronogramas = $request->cronogramas;
            foreach ($cronogramas as $c) {
                $nueva_solicitud_mantenimiento->cronogramas()->create([
                    "descripcion" => mb_strtoupper($c["descripcion"]),
                    "date" => $c["date"],
                    "user_id" => Auth::user()->id,
                ]);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_solicitud_mantenimiento, "solicitud_mantenimientos");
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

    public function getById(SolicitudMantenimiento $solicitud_mantenimiento)
    {
        return response()->JSON([
            "solicitud_mantenimiento" => $solicitud_mantenimiento->load(["cronogramas", "biometrico.unidad_area.user"])
        ]);
    }

    public function edit(SolicitudMantenimiento $solicitud_mantenimiento)
    {
        $solicitud_mantenimiento = $solicitud_mantenimiento->load(["cronogramas"]);
        return Inertia::render('SolicitudMantenimientos/Edit', compact('solicitud_mantenimiento'));
    }

    public function update(SolicitudMantenimiento $solicitud_mantenimiento, Request $request)
    {
        if (Auth::user()->tipo == 'JEFE DE ÁREA' || Auth::user()->tipo == 'ADMINISTRADOR') {
            $this->validacion["biometrico_id"] = "required";
            $this->validacion["nombre_responsable"] = "required|min:1";
            $this->validacion["motivo_mantenimiento"] = "required|min:1";
            $this->validacion["fecha_solicitud"] = "required|min:1";
            $this->validacion["array_repuestos"] = "required|min:1";
            $this->validacion["cronogramas"] = "required|min:1";
        }
        if (Auth::user()->tipo == 'TÉCNICO') {
            $this->validacion["biometrico_id"] = "required";
            $this->validacion["tipo_mantenimiento"] = "required";
            $this->validacion["nombre_responsable"] = "required|min:1";
            $this->validacion["motivo_mantenimiento"] = "required|min:1";
            $this->validacion["fecha_solicitud"] = "required|date";
            // $this->validacion["fecha_entrega"] = "required|date";
            $this->validacion["array_repuestos"] = "required|min:1";
            $this->validacion["cronogramas"] = "required|min:1";
        }

        if (!$request->fecha_entrega) {
            unset($request["fecha_entrega"]);
        }
        if (!$request->cronogramas || count($request->cronogramas) <= 0) {
            throw ValidationException::withMessages([
                "cronogramas" => "Debes completar el cronograma",
                "error" => "Debes completar el cronograma",
            ]);
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($solicitud_mantenimiento, "solicitud_mantenimientos");
            $repuestos = implode(",", $request->array_repuestos);
            $request["repuestos"] = $repuestos;
            $solicitud_mantenimiento->update(array_map('mb_strtoupper', $request->except("cronogramas", "array_repuestos", "eliminados")));
            $eliminados = $request->eliminados;
            if ($eliminados && count($eliminados) > 0) {
                foreach ($eliminados as $e) {
                    $cronograma = Cronograma::find($e);
                    $cronograma->delete();
                }
            }
            $cronogramas = $request->cronogramas;
            foreach ($cronogramas as $c) {
                if (strpos($c["id"], "n-") > -1) {
                    $solicitud_mantenimiento->cronogramas()->create([
                        "descripcion" => mb_strtoupper($c["descripcion"]),
                        "date" => $c["date"],
                        "user_id" => Auth::user()->id,
                    ]);
                } else {
                    $cronograma = Cronograma::find($c["id"]);
                    $cronograma->update([
                        "descripcion" => mb_strtoupper($c["descripcion"]),
                        "date" => $c["date"],
                    ]);
                }
            }

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
            $solicitud_mantenimiento->cronogramas()->delete();
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
