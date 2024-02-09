<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Servicio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class ServicioController extends Controller
{
    public $validacion = [
        "solicitud_mantenimiento_id" => "required",
        "fecha_entrega" => "required|date",
        "procedimientos" => "required|min:1",
        "trabajo_realizado" => "required|min:1",
    ];

    public $mensajes = [
        "solicitud_mantenimiento_id.required" => "Este campo es obligatorio",
        "fecha_entrega.required" => "Este campo es obligatorio",
        "fecha_entrega.date" => "Debes ingresar una fecha valida",
        "procedimientos.required" => "Este campo es obligatorio",
        "procedimientos.min" => "Debes ingresar al menos :min caracter",
        "trabajo_realizado.required" => "Este campo es obligatorio",
        "trabajo_realizado.min" => "Debes ingresar al menos :min caracter",
        "fecha_ini.required" => "Este campo es obligatorio",
        "fecha_ini.date" => "Debes ingresar una fecha valida",
        "fecha_fin.required" => "Este campo es obligatorio",
        "fecha_fin.date" => "Debes ingresar una fecha valida",
        "descripcion.required" => "Este campo es obligatorio",
        "descripcion.min" => "Debes ingresar al menos :min caracter",
    ];

    public function index()
    {
        return Inertia::render("Servicios/Index");
    }

    public function listado()
    {
        $servicios = Servicio::all();
        return response()->JSON([
            "servicios" => $servicios
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $servicios = Servicio::with(["solicitud_mantenimiento.biometrico.unidad_area.user"])->select("servicios.*");

        if (trim($search) != "") {
            $servicios->join("solicitud_mantenimientos", "solicitud_mantenimientos.id", "=", "servicios.solicitud_mantenimiento_id");
            $servicios->where("codigo", "LIKE", "%$search%");
        }

        $servicios = $servicios->paginate($request->itemsPerPage);
        return response()->JSON([
            "servicios" => $servicios
        ]);
    }

    public function create()
    {
        return Inertia::render('Servicios/Create');
    }
    public function store(Request $request)
    {
        if ($request->capacitacion == "SI") {
            $this->validacion["descripcion"] = "required|min:1";
            $this->validacion["fecha_ini"] = "required|date";
            $this->validacion["fecha_fin"] = "required|date";
        } else {
            unset($request["fecha_ini"]);
            unset($request["fecha_fin"]);
        }

        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Servicio
            $nuevo_servicio = Servicio::create(array_map('mb_strtoupper', $request->all()));
            $nuevo_servicio->solicitud_mantenimiento->fecha_entrega = $nuevo_servicio->fecha_entrega;
            $nuevo_servicio->solicitud_mantenimiento->save();
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_servicio, "servicios");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->servicio . ' REGISTRO UN SERVICIO',
                'datos_original' => $datos_original,
                'modulo' => 'SERVICIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("servicios.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Servicio $servicio)
    {
    }

    public function edit(Servicio $servicio)
    {
        $servicio = $servicio->load(["solicitud_mantenimiento"]);
        return Inertia::render('Servicios/Edit', compact('servicio'));
    }
    public function update(Servicio $servicio, Request $request)
    {
        if ($request->capacitacion == "SI") {
            $this->validacion["descripcion"] = "required|min:1";
            $this->validacion["fecha_ini"] = "required|date";
            $this->validacion["fecha_fin"] = "required|date";
        } else {
            unset($request["fecha_ini"]);
            unset($request["fecha_fin"]);
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($servicio, "servicios");
            $servicio->update(array_map('mb_strtoupper', $request->all()));
            $servicio->solicitud_mantenimiento->fecha_entrega = $servicio->fecha_entrega;
            $servicio->solicitud_mantenimiento->save();
            if ($servicio->capacitacion == "NO") {
                $servicio->descripcion = NULL;
                $servicio->fecha_ini = NULL;
                $servicio->fecha_fin = NULL;
                $servicio->save();
            }
            $datos_nuevo = HistorialAccion::getDetalleRegistro($servicio, "servicios");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->servicio . ' MODIFICÓ UN SERVICIO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'SERVICIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return redirect()->route("servicios.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Servicio $servicio)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($servicio, "servicios");
            $servicio->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->servicio . ' ELIMINÓ UN SERVICIO',
                'datos_original' => $datos_original,
                'modulo' => 'SERVICIOS',
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
