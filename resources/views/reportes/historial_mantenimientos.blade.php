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
            margin-bottom: 0.5cm;
            margin-left: 0.2cm;
            margin-right: 0.2cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 40px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 8pt;
        }

        table tbody tr td {
            font-size: 6.7pt;
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
            top: -20px;
            right: 20px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
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
            background: rgb(202, 202, 202);
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

        .border_top {
            border-top: solid 1px black;
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

        td.foto img {
            width: 40px;
        }

        .text-md {
            font-size: 0.85em;
        }
    </style>
</head>

<body>
    @inject('institucion', 'App\Models\Institucion')
    @php
        $cont = 0;
    @endphp
    @foreach ($biometricos as $biometrico)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $institucion->first()->url_logo }}">
            </div>
            <div class="logo2">
                <img src="{{ $institucion->first()->url_logo2 }}">
            </div>
            <h2 class="titulo">
                {{ $institucion->first()->nombre }}
            </h2>
            <h4 class="texto">HISTORIAL DE MANTENIMIENTO DE EQUIPO</h4>
        </div>

        <table border="1">
            <thead>
                <tr>
                    <th colspan="13" class="text-md">{{ $biometrico->serie }} - {{ $biometrico->nombre }}</th>
                </tr>
                <tr>
                    <th width="2%">N°</th>
                    <th>Código Solicitud</th>
                    <th>Fecha de Solicitud</th>
                    <th>Fecha de Entrega</th>
                    <th>Repuestos</th>
                    <th>Responsable</th>
                    <th>Técnico</th>
                    <th>Tipo de Mantenimiento</th>
                    <th>Motivo de Mantenimiento</th>
                    <th>Procedimientos</th>
                    <th>Observaciones</th>
                    <th>Estado del Equipo</th>
                    <th width="20%">Trabajo realizado</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $nro_reg = 1;
                    $solicitud_mantenimientos = $biometrico->solicitud_mantenimientos;
                @endphp
                @if (count($solicitud_mantenimientos) > 0)
                    @foreach ($solicitud_mantenimientos as $sm)
                        <tr>
                            <td>{{ $nro_reg++ }}</td>
                            <td>{{ $sm->codigo }}</td>
                            <td>{{ $sm->fecha_solicitud_t }}</td>
                            <td>{{ $sm->fecha_entrega_t }}</td>
                            <td>{{ $sm->repuestos_txt }}</td>
                            <td>{{ $sm->responsable ? $sm->responsable->full_name : '' }}</td>
                            <td>{{ $sm->responsable ? $sm->tecnico->full_name : '' }}</td>
                            <td>{{ $sm->tipo_mantenimiento }}</td>
                            <td>{{ $sm->motivo_mantenimiento }}</td>
                            <td>{{ $sm->servicio ? $sm->servicio->procedimientos : '' }}</td>
                            <td>{{ $sm->servicio ? $sm->servicio->observaciones : '' }}</td>
                            <td>{{ $sm->servicio ? $sm->servicio->estado_equipo : '' }}</td>
                            <td>{{ $sm->servicio ? $sm->servicio->trabajo_realizado : '' }}</td>

                        </tr>
                    @endforeach
                @else
                    <tr>
                        <td colspan="13">SIN REGISTROS</td>
                    </tr>
                @endif
            </tbody>
        </table>
        @php
            $cont++;
        @endphp
        @if ($cont < count($biometricos))
            <div class="break_page"></div>
        @endif
    @endforeach
</body>

</html>
