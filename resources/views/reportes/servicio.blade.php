<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Solicitud de Mantenimiento</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 1cm;
            margin-left: 1.5cm;
            margin-right: 1cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 40px;
            border-spacing: 0px 5px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 9pt;
        }

        table tbody tr td {
            font-size: 8pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 90px;
            top: -20px;
            left: 20px;
        }

        .logo2 img {
            position: absolute;
            height: 90px;
            top: -20px;
            right: 20px;
        }

        .qr img {
            position: absolute;
            height: 65px;
            top: 77px;
            right: 20px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 30px;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 400px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .bold {
            font-weight: bold;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(236, 236, 236)
        }

        .bg-principal {
            background: #c57a40;
            color: white;
        }

        .img_celda img {
            width: 45px;
        }

        .break_page {
            page-break-after: always;
        }

        .border_bot {
            border-bottom: solid 1px black;
        }

        .padding_top {
            padding-top: 6px;
        }

        .padding_bot {
            padding-bottom: 6px;
        }

        .firma {
            margin-top: 100px;
            border-collapse: separate;
            border-spacing: 40px 0px;
        }

        .firma tbody tr td {
            text-align: center;
            padding: 0px;
        }

        .firma tbody tr:nth-child(1) td {
            border-bottom: dotted 2px black;
        }
    </style>
</head>

<body>
    @inject('institucion', 'App\Models\Institucion')
    @php
        $cont = 0;
    @endphp
    @forelse ($servicios as $s)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $institucion->first()->url_logo }}">
            </div>
            <div class="logo2">
                <img src="{{ $institucion->first()->url_logo2 }}">
            </div>
            <div class="qr">
                <img src="{{ $s->solicitud_mantenimiento->qr }}" alt="">
            </div>
            <h2 class="titulo">
                {{ $institucion->first()->nombre }}
            </h2>
            <h4 class="texto">ORDEN DE SERVICIO TÉCNICO</h4>
        </div>

        <table border="1" style="margin-top:60px;">
            <tbody>
                <tr>
                    <td class="bold gray" colspan="6">DATOS DEL CLIENTE</td>
                </tr>
                <tr>
                    <td class="bold" width="16%">Nombre: </td>
                    <td colspan="2">{{ $s->solicitud_mantenimiento->biometrico->empresa->nombre }}</td>
                    <td class="bold">Unidad:</td>
                    <td colspan="2">{{ $s->solicitud_mantenimiento->biometrico->unidad_area->nombre }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">Dirección: </td>
                    <td colspan="2">{{ $s->solicitud_mantenimiento->biometrico->empresa->dir }}</td>
                    <td class="bold">Teléfono:</td>
                    <td colspan="2">{{ $s->solicitud_mantenimiento->biometrico->empresa->fono }}</td>
                </tr>
                <tr>
                    <td class="bold ">DATOS DEL EQUIPO: </td>
                    <td colspan="5" class="">{{ $s->solicitud_mantenimiento->biometrico->nombre }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">Marca: </td>
                    <td>{{ $s->solicitud_mantenimiento->biometrico->marca }}</td>
                    <td class="bold">Modelo:</td>
                    <td>{{ $s->solicitud_mantenimiento->biometrico->modelo }}</td>
                    <td class="bold">N° Serie:</td>
                    <td>{{ $s->solicitud_mantenimiento->biometrico->serie }}</td>
                </tr>
                <tr>
                    <td class="bold gray" colspan="6">DATOS DEL REPONSABLE </td>
                </tr>
                <tr>
                    <td class="bold" width="20%">Nombre: </td>
                    <td colspan="2">
                        {{ $s->solicitud_mantenimiento->responsable ? $s->solicitud_mantenimiento->responsable->full_name : '' }}
                    </td>
                    <td class="bold">C.I.:</td>
                    <td colspan="2">
                        {{ $s->solicitud_mantenimiento->responsable ? $s->solicitud_mantenimiento->responsable->full_ci : '' }}
                    </td>
                </tr>
                <tr>
                    <td class="bold gray" colspan="6">DATOS DEL PERSONAL TÉCNICO </td>
                </tr>
                <tr>
                    <td class="bold" width="20%">Nombre: </td>
                    <td colspan="2">
                        {{ $s->solicitud_mantenimiento->tecnico ? $s->solicitud_mantenimiento->tecnico->full_name : '' }}
                    </td>
                    <td class="bold">C.I.:</td>
                    <td colspan="2">
                        {{ $s->solicitud_mantenimiento->tecnico ? $s->solicitud_mantenimiento->tecnico->full_ci : '' }}
                    </td>
                </tr>
                <tr>
                    <td class="bold gray" colspan="6">TIPO DE ASISTENCIA </td>
                </tr>
                <tr>
                    <td class="bold" width="20%">Otros: </td>
                    <td colspan="5">{{ $s->solicitud_mantenimiento->otros }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">Capacitación: </td>
                    <td colspan="2">{{ $s->capacitacion }}</td>
                    <td class="bold">Descripción:</td>
                    <td colspan="2">{{ $s->descripcion }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">Fecha Inicio: </td>
                    <td colspan="2">{{ $s->fecha_ini_t }}</td>
                    <td class="bold">Fecha Fin:</td>
                    <td colspan="2">{{ $s->fecha_fin_t }}</td>
                </tr>
                <tr>
                    <td class="bold gray" colspan="6">PROBLEMAS REPORTADOS POR EL CLIENTE </td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">MOTIVO DE MANTENIMIENTO: </td>
                    <td colspan="5">{{ $s->solicitud_mantenimiento->motivo_mantenimiento }}</td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">DIAGONOSTICO: </td>
                    <td colspan="5">{{ $s->solicitud_mantenimiento->diagnostico }}</td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">OTROS: </td>
                    <td colspan="5">{{ $s->solicitud_mantenimiento->otros }}</td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">TIPO DE MANTENIMIENTO: </td>
                    <td colspan="5">{{ $s->solicitud_mantenimiento->tipo_mantenimiento }}</td>
                </tr>
                <tr>
                    <td class="bold gray" colspan="6">SERVICIO REALIZADO </td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">DIAGNOSTICO PREVIO: </td>
                    <td colspan="5">{{ $s->diagnostico_previo }}</td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">TRABAJO REALIZADO: </td>
                    <td colspan="5">{{ $s->trabajo_realizado }}</td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">RECOMENDACIONES: </td>
                    <td colspan="5">{{ $s->recomendaciones }}</td>
                </tr>
                <tr>
                    <td class="bold padding_top padding_bot">OBSERVACIONES: </td>
                    <td colspan="5">{{ $s->observaciones }}</td>
                </tr>
            </tbody>
        </table>

        <table class="firma">
            <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>JEFE DE ÁREA</td>
                    <td>TÉCNICO</td>
                    <td>RESPONSABLE DE MANTENIMIENTO</td>
                </tr>
            </tbody>
        </table>

        @php
            $cont++;
        @endphp
        @if ($cont < count($servicios))
            <div class="break_page"></div>
        @endif
    @empty
        <h4 class="texto">SIN REGISTROS</h4>
    @endforelse
</body>

</html>
