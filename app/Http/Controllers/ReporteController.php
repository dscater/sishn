<?php

namespace App\Http\Controllers;

use App\Models\Biometrico;
use App\Models\Servicio;
use App\Models\SolicitudMantenimiento;
use App\Models\UnidadArea;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use PDF;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class ReporteController extends Controller
{
    public function usuarios()
    {
        return Inertia::render("Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        $tipo =  $request->tipo;
        $usuarios = User::where('id', '!=', 1)->orderBy("paterno", "ASC")->get();

        if ($tipo != 'TODOS') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios = User::where('id', '!=', 1)->where('tipo', $request->tipo)->orderBy("paterno", "ASC")->get();
        }

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 85, $alto - 35, date("d/m/Y"), null, 9, array(0, 0, 0));
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('Usuarios.pdf');
    }

    public function solicitud_mantenimiento()
    {
        return Inertia::render("Reportes/SolicitudMantenimiento");
    }

    public function r_solicitud_mantenimiento(Request $request)
    {
        $unidad_area_id =  $request->unidad_area_id;
        $solicitud_mantenimiento_id =  $request->solicitud_mantenimiento_id;
        $unidad_area = UnidadArea::find($unidad_area_id);
        $solicitud_mantenimientos = SolicitudMantenimiento::where("id", $solicitud_mantenimiento_id)->get();
        $pdf = PDF::loadView('reportes.solicitud_mantenimiento', compact('solicitud_mantenimientos', 'unidad_area'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 85, $alto - 35, date("d/m/Y"), null, 9, array(0, 0, 0));
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('solicitud_mantenimiento.pdf');
    }

    public function servicio()
    {
        return Inertia::render("Reportes/Servicio");
    }

    public function r_servicio(Request $request)
    {
        $unidad_area_id =  $request->unidad_area_id;
        $solicitud_mantenimiento_id =  $request->solicitud_mantenimiento_id;
        $unidad_area = UnidadArea::find($unidad_area_id);
        $servicios = Servicio::where("solicitud_mantenimiento_id", $solicitud_mantenimiento_id)->get();
        $pdf = PDF::loadView('reportes.servicio', compact('servicios', 'unidad_area'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 85, $alto - 35, date("d/m/Y"), null, 9, array(0, 0, 0));
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('servicio.pdf');
    }

    public function equipos()
    {
        return Inertia::render("Reportes/Equipos");
    }

    public function r_equipos(Request $request)
    {
        $unidad_area_id =  $request->unidad_area_id;
        $unidad_areas = [];
        if ($unidad_area_id != 'todos') {
            $unidad_areas = UnidadArea::where("id", $unidad_area_id)->get();
        } else {
            $unidad_areas = UnidadArea::all();
        }
        $pdf = PDF::loadView('reportes.equipos', compact('unidad_areas'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 85, $alto - 35, date("d/m/Y"), null, 9, array(0, 0, 0));
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('equipos.pdf');
    }

    public function historial_mantenimientos()
    {
        return Inertia::render("Reportes/HistorialMantenimientos");
    }

    public function r_historial_mantenimientos(Request $request)
    {
        $biometrico_id =  $request->biometrico_id;
        $biometricos = [];
        if ($biometrico_id != 'todos') {
            $biometricos = Biometrico::where("id", $biometrico_id)->get();
        } else {
            $biometricos = Biometrico::all();
        }
        $pdf = PDF::loadView('reportes.historial_mantenimientos', compact('biometricos'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 85, $alto - 35, date("d/m/Y"), null, 9, array(0, 0, 0));
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('historial_mantenimientos.pdf');
    }
}
