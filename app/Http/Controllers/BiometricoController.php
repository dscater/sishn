<?php

namespace App\Http\Controllers;

use App\Models\Biometrico;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class BiometricoController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1",
        "fecha_ingreso" => "required|date",
        "unidad_area_id" => "required",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "fecha_ingreso.required" => "Este campo es obligatorio",
        "fecha_ingreso.date" => "Debes ingresar una fecha valida",
        "unidad_area_id.required" => "Este campo es obligatorio",
        "empresa_id.required" => "Este campo es obligatorio",
        "manual_usuario.file" => "El archvo no puede superar los :max KB",
        "manual_servicio.file" => "El archvo no puede superar los :max KB",
        "serie.unique" => "Esta serie ya fue registrada",
    ];

    public function index()
    {
        return Inertia::render("Biometricos/Index");
    }

    public function listado()
    {
        $biometricos = Biometrico::select("biometricos.*");

        if (Auth::user()->tipo == 'JEFE DE ÁREA') {
            $unidad_area = Auth::user()->unidad_area;
            $biometricos = $biometricos->where("unidad_area_id", $unidad_area->id);
        }
        $biometricos = $biometricos->get();

        return response()->JSON([
            "biometricos" => $biometricos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $biometricos = Biometrico::select("biometricos.*")->with(["unidad_area", "empresa"])
            ->join("unidad_areas", "unidad_areas.id", "=", "biometricos.unidad_area_id");
        if (Auth::user()->tipo == 'JEFE DE ÁREA') {
            $unidad_area = Auth::user()->unidad_area;
            $biometricos = $biometricos->where("unidad_area_id", $unidad_area->id);
        }
        if (trim($search) != "") {
            $biometricos->where("biometricos.nombre", "LIKE", "%$search%");
            $biometricos->orWhere("unidad_areas.nombre", "LIKE", "%$search%");
        }
        if ($request->order) {
            $biometricos->orderBy("id", $request->order);
        }
        $biometricos = $biometricos->paginate($request->itemsPerPage);
        return response()->JSON([
            "biometricos" => $biometricos
        ]);
    }

    public function store(Request $request)
    {
        if ($request->serie && $request->serie != "") {
            $this->validacion['serie'] = 'required|unique:biometricos,serie';
        }

        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }
        if ($request->hasFile('manual_usuario')) {
            $this->validacion['manual_usuario'] = 'file|max:4096';
        }
        if ($request->hasFile('manual_servicio')) {
            $this->validacion['manual_servicio'] = 'file|max:4096';
        }

        if ($request->garantia == 'SI') {
            $this->validacion['empresa_id'] = 'required';
        } else {
            $request["empresa_id"] = 0;
        }


        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear la Biometrico
            $nuevo_biometrico = Biometrico::create(array_map('mb_strtoupper', $request->except('foto', "manual_usuario", "manual_servicio")));
            if ($request->hasFile('foto')) {
                $file = $request->foto;
                $nom_foto = time() . '_' . $nuevo_biometrico->id . '.' . $file->getClientOriginalExtension();
                $nuevo_biometrico->foto = $nom_foto;
                $file->move(public_path() . '/imgs/biometricos/', $nom_foto);
            }
            if ($request->hasFile('manual_usuario')) {
                $file = $request->manual_usuario;
                $nom_manual_usuario = time() . '1_' . $nuevo_biometrico->id . '.' . $file->getClientOriginalExtension();
                $nuevo_biometrico->manual_usuario = $nom_manual_usuario;
                $file->move(public_path() . '/files/', $nom_manual_usuario);
            }
            if ($request->hasFile('manual_servicio')) {
                $file = $request->manual_servicio;
                $nom_manual_servicio = time() . '2_' . $nuevo_biometrico->id . '.' . $file->getClientOriginalExtension();
                $nuevo_biometrico->manual_servicio = $nom_manual_servicio;
                $file->move(public_path() . '/files/', $nom_manual_servicio);
            }

            if ($request->garantia == 'NO') {
                $nuevo_biometrico->empresa_id = null;
            }

            $nuevo_biometrico->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_biometrico, "biometricos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN BIOMETRICO',
                'datos_original' => $datos_original,
                'modulo' => 'BIOMETRICOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("biometricos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Biometrico $biometrico)
    {
    }

    public function update(Biometrico $biometrico, Request $request)
    {
        if ($request->serie && $request->serie != "") {
            $this->validacion['serie'] = 'required|unique:biometricos,serie,' . $biometrico->id;
        }

        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }
        if ($request->hasFile('manual_usuario')) {
            $this->validacion['manual_usuario'] = 'file|max:4096';
        }
        if ($request->hasFile('manual_servicio')) {
            $this->validacion['manual_servicio'] = 'file|max:4096';
        }

        if ($request->garantia == 'SI') {
            $this->validacion['empresa_id'] = 'required';
        } else {
            $request["empresa_id"] = 0;
        }

        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($biometrico, "biometricos");
            $biometrico->update(array_map('mb_strtoupper', $request->except('foto', "manual_usuario", "manual_servicio")));
            if ($request->hasFile('foto')) {
                $antiguo = $biometrico->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/biometricos/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $biometrico->id . '.' . $file->getClientOriginalExtension();
                $biometrico->foto = $nom_foto;
                $file->move(public_path() . '/imgs/biometricos/', $nom_foto);
            }
            if ($request->hasFile('manual_usuario')) {
                $antiguo = $biometrico->manual_usuario;
                if ($antiguo) {
                    \File::delete(public_path() . '/files/' . $antiguo);
                }
                $file = $request->manual_usuario;
                $nom_manual_usuario = time() . '_1' . $biometrico->id . '.' . $file->getClientOriginalExtension();
                $biometrico->manual_usuario = $nom_manual_usuario;
                $file->move(public_path() . '/files/', $nom_manual_usuario);
            }
            if ($request->hasFile('manual_servicio')) {
                $antiguo = $biometrico->manual_servicio;
                if ($antiguo) {
                    \File::delete(public_path() . '/files/' . $antiguo);
                }
                $file = $request->manual_servicio;
                $nom_manual_servicio = time() . '_2' . $biometrico->id . '.' . $file->getClientOriginalExtension();
                $biometrico->manual_servicio = $nom_manual_servicio;
                $file->move(public_path() . '/files/', $nom_manual_servicio);
            }


            if ($request->garantia == 'NO') {
                $biometrico->empresa_id = null;
            }
            $biometrico->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($biometrico, "biometricos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN BIOMETRICO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'BIOMETRICOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("biometricos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Biometrico $biometrico)
    {
        DB::beginTransaction();
        try {
            $antiguo = $biometrico->foto;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/biometricos/' . $antiguo);
            }
            $antiguo = $biometrico->manual_usuario;
            if ($antiguo) {
                \File::delete(public_path() . '/files/' . $antiguo);
            }
            $antiguo = $biometrico->manual_servicio;
            if ($antiguo) {
                \File::delete(public_path() . '/files/' . $antiguo);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($biometrico, "biometricos");
            $biometrico->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN BIOMETRICO',
                'datos_original' => $datos_original,
                'modulo' => 'BIOMETRICOS',
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
