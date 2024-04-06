<?php

namespace App\Http\Controllers;

use App\Models\DocumentoArchivo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DocumentoArchivoController extends Controller
{
    public function destroy(DocumentoArchivo $documento_archivo)
    {
        DB::beginTransaction();
        try {
            $documento = $documento_archivo->documento;
            $ruta_archivo  = public_path("files/" . $documento_archivo->archivo);
            $documento_archivo->delete();
            DB::commit();
            if (file_exists($ruta_archivo)) {
                \File::delete($ruta_archivo);
            }
            return response()->JSON([
                "message" => "Registro eliminado",
                "documento" => $documento->load("documento_archivos")
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 500);
        }
    }
}
