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
        $acceso =  $request->acceso;
        $usuarios = User::where('id', '!=', 1)->where("status", 1);

        if ($tipo != 'TODOS') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios->where('tipo', $request->tipo);
        }

        if ($acceso != 'TODOS') {
            $usuarios->where('acceso', $acceso);
        }

        $usuarios = $usuarios->orderBy("paterno", "ASC")->get();
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
        $solicitud_mantenimientos = SolicitudMantenimiento::where("id", $solicitud_mantenimiento_id)->where("status", 1)->get();
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
        $servicios = Servicio::where("solicitud_mantenimiento_id", $solicitud_mantenimiento_id)->where("status", 1)->get();
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
            $unidad_areas = UnidadArea::where("id", $unidad_area_id)->where("status", 1)->get();
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
            $biometricos = Biometrico::where("status", 1)->get();
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

    public function cantidad_mantenimiento_equipos()
    {
        return Inertia::render("Reportes/CantidadMantenimientoEquipos");
    }

    public function r_cantidad_mantenimiento_equipos(Request $request)
    {
        $unidad_area_id = $request->unidad_area_id;
        $biometrico_id = $request->biometrico_id;

        $categories = [];

        $unidad_areas = UnidadArea::all();

        if ($unidad_area_id != 'todos') {
            $unidad_areas = UnidadArea::where("id", $unidad_area_id)->get();
        }

        $data = [];
        foreach ($unidad_areas as $key => $unidad_area) {
            $data[] = [
                "name" => $unidad_area->nombre,
                "data" => [],
            ];

            $biometricos = Biometrico::where("unidad_area_id", $unidad_area->id)->where("status", 1)->get();
            if ($unidad_area_id != 'todos' && $biometrico_id != 'todos') {
                $biometricos = Biometrico::where("unidad_area_id", $unidad_area->id)->where("id", $biometrico_id)->get();
            }
            foreach ($biometricos as $b) {
                $c_solicitud_mantenimientos = SolicitudMantenimiento::where("biometrico_id", $b->id)->where("status", 1)->count();
                $data[$key]["data"][] = [
                    "name" => $b->serie ? $b->serie . ' (' . $b->nombre . ')' : $b->nombre,
                    "y" => (int)$c_solicitud_mantenimientos,
                ];
            }
        }

        return response()->JSON([
            "data" => $data
        ]);
    }

    public function cantidad_mantenimiento_mes()
    {
        return Inertia::render("Reportes/CantidadMantenimientoMes");
    }

    public function r_cantidad_mantenimiento_mes(Request $request)
    {
        $gestion_actual = date("Y");
        $gestion = $request->gestion;
        $mes = $request->mes;
        $unidad_area_id = $request->unidad_area_id;
        $biometrico_id = $request->biometrico_id;

        $array_meses = [
            1 => "Enero",
            2 => "Febrero",
            3 => "Marzo",
            4 => "Abril",
            5 => "Mayo",
            6 => "Junio",
            7 => "Julio",
            8 => "Agosto",
            9 => "Septiembre",
            10 => "Octubre",
            11 => "Noviembre",
            12 => "Diciembre",
        ];


        $categories = [];
        $series = [];
        if ($gestion <= $gestion_actual) {

            if ($mes == 'todos') {
                $enero = 1;
                $ultimo_mes = 12;
                if ($gestion == $gestion_actual) {
                    $mes_actual = (int)date("m");
                    $ultimo_mes = $mes_actual;
                }

                for ($i = $enero; $i <= $ultimo_mes; $i++) {
                    $categories[] = $array_meses[$i];
                }
            } else {
                $categories[] = $array_meses[$mes];
                $enero = $mes;
                $ultimo_mes = $mes;
            }

            $biometricos = Biometrico::where("status", 1)->get();
            if ($unidad_area_id != 'todos') {
                $biometricos = Biometrico::where("unidad_area_id", $unidad_area_id)->where("status", 1)->get();
            }
            if ($unidad_area_id != 'todos' && $biometrico_id != 'todos') {
                $biometricos = Biometrico::where("unidad_area_id", $unidad_area_id)->where("id", $biometrico_id)->get();
            }
            foreach ($biometricos as $key => $b) {
                $name = "<strong>" . $b->unidad_area->nombre . "</strong><br>";
                $name .= $b->serie ?  $b->serie . ' <br/><small class="text-small">(' . $b->nombre . ')</small>' : $b->nombre;
                $series[] = [
                    "name" => $name,
                    "data" => [],
                ];

                for ($i = $enero; $i <= $ultimo_mes; $i++) {
                    $mes_txt = $i < 10 ? '0' . $i : $i;
                    $fecha_buscar = $gestion . "-" . $mes_txt;
                    $c_solicitud_mantenimientos = SolicitudMantenimiento::where("biometrico_id", $b->id)->where("fecha_solicitud", "LIKE", "$fecha_buscar%")->where("status", 1)->count();
                    $series[$key]["data"][] = [
                        "name" => $array_meses[$i],
                        "y" => (int)$c_solicitud_mantenimientos,
                    ];
                }
            }
        }


        return response()->JSON([
            "categories" => $categories,
            "series" => $series,
        ]);
    }
}
