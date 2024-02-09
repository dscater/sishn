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
            margin-top: 20px;
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

        .qr img {
            position: absolute;
            height: 90px;
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
    </style>
</head>

<body>
    @inject('institucion', 'App\Models\Institucion')
    @php
        $cont = 0;
    @endphp
    @foreach ($solicitud_mantenimientos as $sm)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $institucion->first()->url_logo }}">
            </div>
            <div class="qr">
                <img src="{{ $sm->qr }}" alt="">
            </div>
            <h4 class="texto">SOLICITUD MANTENIMIENTO Y/O REPARACIÓN</h4>
            <h4 class="texto">UNIDAD DE SERVICIOS GENERALES</h4>
        </div>

        <table border="1">
            <tbody>
                <tr>
                    <td class="bold" width="20%">CÓDIGO: </td>
                    <td colspan="3">{{ $sm->codigo }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">UNIDAD SOLICITANTE: </td>
                    <td colspan="3">{{ $unidad_area->nombre }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">FECHA DE SOLICITUD: </td>
                    <td>{{ $sm->fecha_solicitud_t }}</td>
                    <td class="bold" width="20%">FECHA DE ENTREGA: </td>
                    <td>{{ $sm->fecha_entrega_t }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">NOMBRE DEL RESPONSABLE: </td>
                    <td>{{ $sm->nombre_responsable }}</td>
                    <td class="bold" width="20%">C.I. RESPONSABLE: </td>
                    <td>{{ $sm->ci_responsable }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">NOMBRE TÉCNICO: </td>
                    <td>{{ $sm->nombre_tecnico }}</td>
                    <td class="bold" width="20%">C.I. TÉCNICO: </td>
                    <td>{{ $sm->ci_tecnico }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">TIPO DE MANTENIMIENTO: </td>
                    <td colspan="3">{{ $sm->tipo_mantenimiento }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">MOTIVO MANTENIMIENTO: </td>
                    <td colspan="3">{{ $sm->motivo_mantenimiento }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">DIAGNOSTICO: </td>
                    <td colspan="3">{{ $sm->diagnostico }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">OTROS: </td>
                    <td colspan="3">{{ $sm->otros }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">EQUIPO: </td>
                    <td colspan="3">{{ $sm->biometrico->nombre }}</td>
                </tr>
                <tr>
                    <td class="bold" width="20%">REPUESTOS: </td>
                    <td colspan="3">
                        {{ $sm->repuestos_txt }}
                    </td>
                </tr>
            </tbody>
        </table>
        @php
            $cont++;
        @endphp
        @if ($cont < count($solicitud_mantenimientos))
            <div class="break_page"></div>
        @endif
    @endforeach
</body>

</html>
