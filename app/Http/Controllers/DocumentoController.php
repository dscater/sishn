<?php

namespace App\Http\Controllers;

use App\Models\Documento;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class DocumentoController extends Controller
{
    public $validacion = [
        "descripcion" => "required",

    ];

    public $mensajes = [
        "descripcion.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Documentos/Index");
    }

    public function listado()
    {
        $documentos = Documento::select("documentos.*")->get();
        return response()->JSON([
            "documentos" => $documentos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $documentos = Documento::with(["documento_archivos"])->select("documentos.*");

        if (trim($search) != "") {
            $documentos->where("descripcion", "LIKE", "%$search%");
        }

        $documentos = $documentos->paginate($request->itemsPerPage);
        return response()->JSON([
            "documentos" => $documentos
        ]);
    }

    public function create()
    {
        return Inertia::render("Documentos/Create");
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Documento
            $nuevo_documento = Documento::create(array_map('mb_strtoupper', $request->except('documento_archivos')));

            if ($request->file("documento_archivos")) {
                $documento_archivos = $request->file('documento_archivos');
                foreach ($documento_archivos as $key => $file) {
                    $nom_archivo = "doc_" . $nuevo_documento->id . "_" . time() . $key . "." . $file->getClientOriginalExtension();
                    $nuevo_documento->documento_archivos()->create([
                        "archivo" => $nom_archivo,
                    ]);
                    $file->move(public_path() . '/files/', $nom_archivo);
                }
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_documento, "documentos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN DOCUMENTO',
                'datos_original' => $datos_original,
                'modulo' => 'DOCUMENTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("documentos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Documento $documento)
    {
    }

    public function edit(Documento $documento)
    {
        return Inertia::render("Documentos/Edit", compact("documento"));
    }

    public function update(Documento $documento, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($documento, "documentos");
            $documento->update(array_map('mb_strtoupper', $request->except('documento_archivos')));

            if ($request->file("documento_archivos")) {
                $documento_archivos = $request->file('documento_archivos');
                foreach ($documento_archivos as $key => $file) {
                    $nom_archivo = "doc_" . ($documento->id) . "_" . time() . $key . "." . $file->getClientOriginalExtension();
                    $documento->documento_archivos()->create([
                        "archivo" => $nom_archivo,
                    ]);
                    $file->move(public_path() . '/files/', $nom_archivo);
                }
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($documento, "documentos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN DOCUMENTO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'DOCUMENTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("documentos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Documento $documento)
    {
        DB::beginTransaction();
        try {
            foreach ($documento->documento_archivos as $item) {
                if (file_exists(public_path("files/" . $item->archivo))) {
                    \File::delete(public_path("files/" . $item->archivo));
                }
                $item->delete();
            }

            $datos_original = HistorialAccion::getDetalleRegistro($documento, "documentos");
            $documento->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN DOCUMENTO',
                'datos_original' => $datos_original,
                'modulo' => 'DOCUMENTOS',
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
