<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class EmpresaController extends Controller
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
        return Inertia::render("Empresas/Index");
    }

    public function listado()
    {
        $empresas = Empresa::select("empresas.*")->get();
        return response()->JSON([
            "empresas" => $empresas
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $empresas = Empresa::select("empresas.*");
        if (trim($search) != "") {
            $empresas->where("nombre", "LIKE", "%$search%");
            $empresas->orWhere("nit", "LIKE", "%$search%");
        }
        $empresas = $empresas->paginate(5);
        return response()->JSON([
            "empresas" => $empresas
        ]);
    }

    public function store(Request $request)
    {
        if ($request->hasFile('logo')) {
            $this->validacion['logo'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }
        if ($request->fecha_ini == "") {
            unset($request["fecha_ini"]);
        }
        if ($request->fecha_fin == "") {
            unset($request["fecha_fin"]);
        }

        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear la Empresa
            $nueva_empresa = Empresa::create(array_map('mb_strtoupper', $request->except('logo')));
            $nueva_empresa->save();
            if ($request->hasFile('logo')) {
                $file = $request->logo;
                $nom_logo = time() . '_' . $nueva_empresa->id . '.' . $file->getClientOriginalExtension();
                $nueva_empresa->logo = $nom_logo;
                $file->move(public_path() . '/imgs/empresas/', $nom_logo);
            }
            $nueva_empresa->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_empresa, "empresas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA EMPRESA',
                'datos_original' => $datos_original,
                'modulo' => 'EMPRESAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("empresas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Empresa $empresa)
    {
    }

    public function update(Empresa $empresa, Request $request)
    {
        if ($request->hasFile('logo')) {
            $this->validacion['logo'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }
        if ($request->fecha_ini == "") {
            unset($request["fecha_ini"]);
        }
        if ($request->fecha_fin == "") {
            unset($request["fecha_fin"]);
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($empresa, "empresas");
            $empresa->update(array_map('mb_strtoupper', $request->except('logo')));
            if ($request->hasFile('logo')) {
                $antiguo = $empresa->logo;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/empresas/' . $antiguo);
                }
                $file = $request->logo;
                $nom_logo = time() . '_' . $empresa->id . '.' . $file->getClientOriginalExtension();
                $empresa->logo = $nom_logo;
                $file->move(public_path() . '/imgs/empresas/', $nom_logo);
            }
            $empresa->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($empresa, "empresas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA EMPRESA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'EMPRESAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("empresas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Empresa $empresa)
    {
        DB::beginTransaction();
        try {
            $antiguo = $empresa->logo;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/empresas/' . $antiguo);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($empresa, "empresas");
            $empresa->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA EMPRESA',
                'datos_original' => $datos_original,
                'modulo' => 'EMPRESAS',
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
