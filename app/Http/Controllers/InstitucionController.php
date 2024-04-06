<?php

namespace App\Http\Controllers;

use App\Models\Institucion;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class InstitucionController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:2",
        "nombre_sistema" => "required|min:2",
        "nit" => "required|min:2",
        "nombre_director" => "required|min:2",
        "dir" => "required|min:2",
    ];

    public $messages = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "nombre_sistema.required" => "Este campo es obligatorio",
        "nombre_sistema.min" => "Debes ingresar al menos :min caracteres",
        "nit.required" => "Este campo es obligatorio",
        "nit.min" => "Debes ingresar al menos :min caracteres",
        "nombre_director.required" => "Este campo es obligatorio",
        "nombre_director.min" => "Debes ingresar al menos :min caracteres",
        "dir.required" => "Este campo es obligatorio",
        "dir.min" => "Debes ingresar al menos :min caracteres",
    ];

    public function index(Request $request)
    {
        if (!UserController::verificaPermiso("institucions.index")) {
            abort(401, "No autorizado");
        }

        $institucion = Institucion::first();

        return Inertia::render("Institucions/Index", compact("institucion"));
    }

    public function getInstitucion()
    {
        $institucion = Institucion::first();
        return response()->JSON([
            "institucion" => $institucion
        ], 200);
    }

    public function update(Institucion $institucion, Request $request)
    {
        $request->validate($this->validacion, $this->messages);
        DB::beginTransaction();
        try {
            $institucion->update(array_map("mb_strtoupper", $request->except("foto_director", "foto_subdirector", "logo", "organigrama", "ubicacion_google")));
            $institucion->ubicacion_google = $request->ubicacion_google;
            if ($request->hasFile('foto_director')) {
                $antiguo = $institucion->foto_director;
                if ($antiguo && $antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                }
                $file = $request->foto_director;
                $nom_foto_director = time() . '_' . $institucion->id . '.' . $file->getClientOriginalExtension();
                $institucion->foto_director = $nom_foto_director;
                $file->move(public_path() . '/imgs/', $nom_foto_director);
            }

            if ($request->hasFile('foto_subdirector')) {
                $antiguo = $institucion->foto_subdirector;
                if ($antiguo && $antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                }
                $file = $request->foto_subdirector;
                $nom_foto_subdirector = time() . '_' . $institucion->id . '.' . $file->getClientOriginalExtension();
                $institucion->foto_subdirector = $nom_foto_subdirector;
                $file->move(public_path() . '/imgs/', $nom_foto_subdirector);
            }

            if ($request->hasFile('logo')) {
                $antiguo = $institucion->logo;
                if ($antiguo && $antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                }
                $file = $request->logo;
                $nom_logo = time() . '_' . $institucion->id . '.' . $file->getClientOriginalExtension();
                $institucion->logo = $nom_logo;
                $file->move(public_path() . '/imgs/', $nom_logo);
            }

            if ($request->hasFile('logo2')) {
                $antiguo = $institucion->logo2;
                if ($antiguo && $antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                }
                $file = $request->logo2;
                $nom_logo2 = time() . '_' . $institucion->id . '.' . $file->getClientOriginalExtension();
                $institucion->logo2 = $nom_logo2;
                $file->move(public_path() . '/imgs/', $nom_logo2);
            }

            if ($request->hasFile('img_organigrama')) {
                $antiguo = $institucion->img_organigrama;
                if ($antiguo && $antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                }
                $file = $request->img_organigrama;
                $nom_img_organigrama = time() . '_' . $institucion->id . '.' . $file->getClientOriginalExtension();
                $institucion->img_organigrama = $nom_img_organigrama;
                $file->move(public_path() . '/imgs/', $nom_img_organigrama);
            }

            $institucion->save();

            DB::commit();
            return redirect()->route("institucions.index")->with("success", "Registro correcto");
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with("error", $e->getMessage());
        }
    }

    public function show(Institucion $institucion)
    {
    }
}
